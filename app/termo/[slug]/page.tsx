import { notFound } from "next/navigation";
import type { Metadata } from "next";
import Markdown from "react-markdown";
import { CategoryBadge } from "@/components/CategoryBadge";
import { RelatedTerms } from "@/components/RelatedTerms";
import { getRelatedTerms, getTermBySlug } from "@/lib/supabase/queries";

const NIVEL_LABEL = {
  basico: "Básico",
  intermediario: "Intermediário",
  avancado: "Avançado",
} as const;

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const term = await getTermBySlug(slug);
  if (!term) return { title: "Termo não encontrado" };
  return {
    title: term.termo,
    description: term.definicao_curta,
  };
}

export default async function TermoPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const term = await getTermBySlug(slug);
  if (!term) notFound();

  const relatedTerms = await getRelatedTerms(term.id);

  return (
    <main className="mx-auto w-full max-w-3xl flex-1 px-6 py-16">
      <div className="flex items-center gap-3">
        <CategoryBadge category={term.category} />
        <span className="text-xs text-zinc-500 dark:text-zinc-400">
          {NIVEL_LABEL[term.nivel]}
        </span>
      </div>

      <h1 className="mt-4 text-3xl font-semibold tracking-tight">
        {term.termo}
      </h1>
      {term.expansao && (
        <p className="mt-1 text-lg text-zinc-500 dark:text-zinc-400">
          {term.expansao}
        </p>
      )}

      <p className="mt-6 text-lg text-zinc-700 dark:text-zinc-300">
        {term.definicao_curta}
      </p>

      <article className="prose prose-zinc mt-6 max-w-none dark:prose-invert">
        <Markdown>{term.definicao_completa}</Markdown>
      </article>

      {term.fontes.length > 0 && (
        <section className="mt-8">
          <h2 className="text-sm font-semibold uppercase tracking-wide text-zinc-500 dark:text-zinc-400">
            Fontes
          </h2>
          <ul className="mt-2 list-inside list-disc text-sm text-zinc-600 dark:text-zinc-400">
            {term.fontes.map((fonte) => (
              <li key={fonte}>
                <a
                  href={fonte}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="underline underline-offset-4"
                >
                  {fonte}
                </a>
              </li>
            ))}
          </ul>
        </section>
      )}

      <RelatedTerms terms={relatedTerms} />
    </main>
  );
}
