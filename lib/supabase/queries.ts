import { createClient } from "@/lib/supabase/client";
import type { Category, RelatedTerm, TermWithCategory } from "@/lib/supabase/types";

export async function getCategories(): Promise<Category[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("categories")
    .select("*")
    .order("nome");

  if (error) throw error;
  return data;
}

export async function getPublishedTerms(): Promise<TermWithCategory[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("terms")
    .select("*, category:categories(*)")
    .eq("status", "publicado")
    .order("termo");

  if (error) throw error;
  return data as unknown as TermWithCategory[];
}

export async function getTermsByCategorySlug(
  categorySlug: string
): Promise<TermWithCategory[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("terms")
    .select("*, category:categories!inner(*)")
    .eq("status", "publicado")
    .eq("category.slug", categorySlug)
    .order("termo");

  if (error) throw error;
  return data as unknown as TermWithCategory[];
}

export async function getTermBySlug(
  slug: string
): Promise<TermWithCategory | null> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("terms")
    .select("*, category:categories(*)")
    .eq("slug", slug)
    .eq("status", "publicado")
    .maybeSingle();

  if (error) throw error;
  return data as unknown as TermWithCategory | null;
}

export async function getRelatedTerms(termId: string): Promise<RelatedTerm[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("term_relations")
    .select("tipo_relacao, related:terms!term_relations_related_term_id_fkey(slug, termo, definicao_curta, status)")
    .eq("term_id", termId);

  if (error) throw error;

  return (data ?? [])
    .filter((row) => (row.related as unknown as { status: string })?.status === "publicado")
    .map((row) => {
      const related = row.related as unknown as {
        slug: string;
        termo: string;
        definicao_curta: string;
      };
      return {
        slug: related.slug,
        termo: related.termo,
        definicao_curta: related.definicao_curta,
        tipo_relacao: row.tipo_relacao,
      };
    });
}

export async function searchTerms(query: string): Promise<TermWithCategory[]> {
  const supabase = createClient();
  const { data, error } = await supabase
    .from("terms")
    .select("*, category:categories(*)")
    .eq("status", "publicado")
    .textSearch("search_vector", query, {
      type: "websearch",
      config: "portuguese",
    })
    .order("termo");

  if (error) throw error;
  return data as unknown as TermWithCategory[];
}
