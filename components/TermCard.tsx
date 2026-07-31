import Link from "next/link";
import type { TermWithCategory } from "@/lib/supabase/types";

export function TermCard({ term }: { term: TermWithCategory }) {
  return (
    <Link
      href={`/termo/${term.slug}`}
      className="block rounded-lg border border-black/10 p-4 transition-colors hover:border-black/30 dark:border-white/10 dark:hover:border-white/30"
    >
      <div className="flex items-baseline justify-between gap-3">
        <h3 className="text-lg font-semibold">{term.termo}</h3>
        <span
          className="h-2 w-2 shrink-0 rounded-full"
          style={{ backgroundColor: term.category.cor }}
          aria-hidden
        />
      </div>
      {term.expansao && (
        <p className="mt-0.5 text-sm text-zinc-500 dark:text-zinc-400">
          {term.expansao}
        </p>
      )}
      <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-300">
        {term.definicao_curta}
      </p>
    </Link>
  );
}
