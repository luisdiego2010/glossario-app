import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { TermCard } from "@/components/TermCard";
import { createClient } from "@/lib/supabase/client";
import { getTermsByCategorySlug } from "@/lib/supabase/queries";
import type { Category } from "@/lib/supabase/types";

async function getCategoryBySlug(slug: string): Promise<Category | null> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("categories")
    .select("*")
    .eq("slug", slug)
    .maybeSingle();

  if (error) throw error;
  return data;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const category = await getCategoryBySlug(slug);
  return { title: category ? category.nome : "Categoria" };
}

export default async function CategoriaPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const category = await getCategoryBySlug(slug);
  if (!category) notFound();

  const terms = await getTermsByCategorySlug(slug);

  return (
    <main className="mx-auto w-full max-w-4xl flex-1 px-6 py-16">
      <span
        className="inline-block rounded-full px-3 py-1 text-xs font-medium text-white"
        style={{ backgroundColor: category.cor }}
      >
        {category.nome}
      </span>
      <h1 className="mt-3 text-2xl font-semibold tracking-tight">
        {category.nome}
      </h1>
      {category.descricao && (
        <p className="mt-2 max-w-2xl text-zinc-600 dark:text-zinc-400">
          {category.descricao}
        </p>
      )}

      {terms.length === 0 ? (
        <p className="mt-8 text-sm text-zinc-500 dark:text-zinc-400">
          Nenhum termo publicado nesta categoria ainda.
        </p>
      ) : (
        <div className="mt-8 grid gap-3 sm:grid-cols-2">
          {terms.map((term) => (
            <TermCard key={term.id} term={term} />
          ))}
        </div>
      )}
    </main>
  );
}
