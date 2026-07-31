import Link from "next/link";
import type { RelatedTerm } from "@/lib/supabase/types";

const LABELS: Record<RelatedTerm["tipo_relacao"], string> = {
  relacionado: "Relacionado",
  pre_requisito: "Pré-requisito",
  veja_tambem: "Veja também",
};

export function RelatedTerms({ terms }: { terms: RelatedTerm[] }) {
  if (terms.length === 0) return null;

  return (
    <section className="mt-10 border-t border-black/10 pt-6 dark:border-white/10">
      <h2 className="text-sm font-semibold uppercase tracking-wide text-zinc-500 dark:text-zinc-400">
        Veja também
      </h2>
      <ul className="mt-3 grid gap-2 sm:grid-cols-2">
        {terms.map((related) => (
          <li key={related.slug}>
            <Link
              href={`/termo/${related.slug}`}
              className="block rounded-md border border-black/10 px-3 py-2 text-sm transition-colors hover:border-black/30 dark:border-white/10 dark:hover:border-white/30"
            >
              <span className="font-medium">{related.termo}</span>
              <span className="ml-2 text-xs text-zinc-500 dark:text-zinc-400">
                {LABELS[related.tipo_relacao]}
              </span>
              <p className="mt-0.5 text-xs text-zinc-500 dark:text-zinc-400">
                {related.definicao_curta}
              </p>
            </Link>
          </li>
        ))}
      </ul>
    </section>
  );
}
