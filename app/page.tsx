import Link from "next/link";
import { SearchBar } from "@/components/SearchBar";
import { CategoryBadge } from "@/components/CategoryBadge";
import { TermCard } from "@/components/TermCard";
import { getCategories, getPublishedTerms } from "@/lib/supabase/queries";

export const dynamic = "force-dynamic";

function pickTermOfTheDay<T>(terms: T[]): T | null {
  if (terms.length === 0) return null;
  const dayIndex = Math.floor(Date.now() / 86_400_000);
  return terms[dayIndex % terms.length];
}

export default async function Home() {
  const [categories, terms] = await Promise.all([
    getCategories(),
    getPublishedTerms(),
  ]);

  const termOfTheDay = pickTermOfTheDay(terms);

  return (
    <main className="mx-auto flex w-full max-w-4xl flex-1 flex-col gap-12 px-6 py-16">
      <section className="flex flex-col items-start gap-4">
        <h1 className="text-3xl font-semibold tracking-tight sm:text-4xl">
          Tecnologia, IA, negócios e saúde — sem sigla sem explicação.
        </h1>
        <p className="max-w-2xl text-zinc-600 dark:text-zinc-400">
          Um glossário curado com definição, contexto de uso e links entre
          termos relacionados.
        </p>
        <SearchBar />
      </section>

      {categories.length > 0 && (
        <section className="flex flex-wrap gap-2">
          {categories.map((category) => (
            <CategoryBadge key={category.id} category={category} />
          ))}
        </section>
      )}

      {termOfTheDay && (
        <section>
          <h2 className="text-sm font-semibold uppercase tracking-wide text-zinc-500 dark:text-zinc-400">
            Termo do dia
          </h2>
          <div className="mt-3">
            <TermCard term={termOfTheDay} />
          </div>
        </section>
      )}

      {terms.length === 0 && (
        <p className="text-sm text-zinc-500 dark:text-zinc-400">
          Nenhum termo publicado ainda. Rode a migration e popule a tabela{" "}
          <code>terms</code> para ver o glossário em ação — veja{" "}
          <code>supabase/seed/0001_terms_seed.sql</code>.
        </p>
      )}

      <Link
        href="/glossario"
        className="text-sm font-medium underline underline-offset-4"
      >
        Ver índice completo A–Z →
      </Link>
    </main>
  );
}
