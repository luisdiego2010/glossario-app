// Script de uso único (admin): insere termos e relações em lote no Supabase,
// usando a service role key. Não faz parte do site — não é importado pelo
// Next.js nem enviado ao navegador.
//
// Uso: node scripts/add-terms.mjs scripts/terms-data.json
import { createClient } from "@supabase/supabase-js";
import { readFile } from "node:fs/promises";

function slugify(text) {
  return text
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !serviceRoleKey) {
  console.error(
    "Defina NEXT_PUBLIC_SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY no ambiente."
  );
  process.exit(1);
}

const dataPath = process.argv[2];
if (!dataPath) {
  console.error("Uso: node scripts/add-terms.mjs <arquivo.json>");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceRoleKey, {
  auth: { persistSession: false },
});

const { terms, relations } = JSON.parse(await readFile(dataPath, "utf8"));

const { data: categories, error: categoriesError } = await supabase
  .from("categories")
  .select("id, slug");
if (categoriesError) throw categoriesError;
const categoryIdBySlug = Object.fromEntries(
  categories.map((c) => [c.slug, c.id])
);

console.log(`Inserindo ${terms.length} termos...`);
for (const term of terms) {
  const categoryId = categoryIdBySlug[term.category_slug];
  if (!categoryId) {
    console.error(`Categoria "${term.category_slug}" não encontrada, pulando "${term.termo}".`);
    continue;
  }

  const slug = term.slug ?? slugify(term.termo);
  const { error } = await supabase.from("terms").upsert(
    {
      slug,
      termo: term.termo,
      expansao: term.expansao ?? null,
      definicao_curta: term.definicao_curta,
      definicao_completa: term.definicao_completa,
      category_id: categoryId,
      nivel: term.nivel ?? "basico",
      status: term.status ?? "publicado",
      fontes: term.fontes ?? [],
    },
    { onConflict: "slug" }
  );

  if (error) {
    console.error(`Erro ao inserir "${term.termo}" (${slug}):`, error.message);
  } else {
    console.log(`OK: ${term.termo} (${slug})`);
  }
}

if (relations?.length) {
  console.log(`\nInserindo ${relations.length} relações...`);
  const { data: allTerms, error: termsError } = await supabase
    .from("terms")
    .select("id, slug");
  if (termsError) throw termsError;
  const termIdBySlug = Object.fromEntries(allTerms.map((t) => [t.slug, t.id]));

  for (const rel of relations) {
    const termId = termIdBySlug[rel.from];
    const relatedTermId = termIdBySlug[rel.to];
    if (!termId || !relatedTermId) {
      console.error(`Relação ignorada (slug não encontrado): ${rel.from} -> ${rel.to}`);
      continue;
    }
    const { error } = await supabase.from("term_relations").upsert(
      {
        term_id: termId,
        related_term_id: relatedTermId,
        tipo_relacao: rel.tipo ?? "relacionado",
      },
      { onConflict: "term_id,related_term_id" }
    );
    if (error) {
      console.error(`Erro na relação ${rel.from} -> ${rel.to}:`, error.message);
    }
  }
}

console.log("\nConcluído.");
