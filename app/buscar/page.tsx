import type { Metadata } from "next";
import { SearchBar } from "@/components/SearchBar";
import { TermCard } from "@/components/TermCard";
import { searchTerms } from "@/lib/supabase/queries";

export const metadata: Metadata = { title: "Buscar" };

export default async function BuscarPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const query = q?.trim() ?? "";
  const results = query ? await searchTerms(query) : [];

  return (
    <main className="mx-auto w-full max-w-4xl flex-1 px-6 py-16">
      <h1 className="text-2xl font-semibold tracking-tight">Buscar</h1>
      <div className="mt-4">
        <SearchBar defaultValue={query} />
      </div>

      {query && (
        <p className="mt-6 text-sm text-zinc-500 dark:text-zinc-400">
          {results.length === 0
            ? `Nenhum resultado para "${query}".`
            : `${results.length} resultado(s) para "${query}".`}
        </p>
      )}

      <div className="mt-6 grid gap-3 sm:grid-cols-2">
        {results.map((term) => (
          <TermCard key={term.id} term={term} />
        ))}
      </div>
    </main>
  );
}
