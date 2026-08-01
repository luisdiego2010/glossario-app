"use server";

import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { slugify } from "@/lib/slug";

export type NewTermState = { error?: string } | undefined;

export async function createTerm(
  _state: NewTermState,
  formData: FormData
): Promise<NewTermState> {
  const termo = String(formData.get("termo") ?? "").trim();
  const expansao = String(formData.get("expansao") ?? "").trim();
  const definicaoCurta = String(formData.get("definicao_curta") ?? "").trim();
  const definicaoCompleta = String(formData.get("definicao_completa") ?? "").trim();
  const categoryId = String(formData.get("category_id") ?? "");
  const nivel = String(formData.get("nivel") ?? "basico");
  const status = String(formData.get("status") ?? "publicado");
  const linkWiki = String(formData.get("link_wiki") ?? "").trim();

  if (!termo || !definicaoCurta || !definicaoCompleta || !categoryId) {
    return { error: "Preencha termo, categoria e as duas definições." };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("terms").insert({
    slug: slugify(termo),
    termo,
    expansao: expansao || null,
    definicao_curta: definicaoCurta,
    definicao_completa: definicaoCompleta,
    category_id: categoryId,
    nivel,
    status,
    fontes: linkWiki ? [linkWiki] : [],
  });

  if (error) {
    if (error.code === "23505") {
      return {
        error: `Já existe um termo parecido com esse nome. Tente um título um pouco diferente.`,
      };
    }
    return { error: `Erro ao salvar: ${error.message}` };
  }

  redirect("/admin");
}
