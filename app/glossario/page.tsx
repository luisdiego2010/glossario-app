import type { Metadata } from "next";
import { TermCard } from "@/components/TermCard";
import { getCategories, getPublishedTerms } from "@/lib/supabase/queries";

export const metadata: Metadata = { title: "Glossário A–Z" };

export default async function GlossarioPage({
  searchParams,
}: {
  searchParams: Promise<{ categoria?: string; nivel?: string }>;
}) {
  const { categoria, nivel } = await searchParams;
  const [categories, allTerms] = await Promise.all([
    getCategories(),
    getPublishedTerms(),
  ]);

  const terms = allTerms.filter((term) => {
    const matchesCategoria = !categoria || term.category.slug === categoria;
    const matchesNivel = !nivel || term.nivel === nivel;
    return matchesCategoria && matchesNivel;
  });

  const grouped = terms.reduce<Record<string, typeof terms>>((acc, term) => {
    const letter = term.termo[0]?.toUpperCase() ?? "#";
    acc[letter] = acc[letter] ? [...acc[letter], term] : [term];
    return acc;
  }, {});

  const letters = Object.keys(grouped).sort();

  return (
    <main className="mx-auto w-full max-w-4xl flex-1 px-6 py-16">
      <h1 className="text-2xl font-semibold tracking-tight">Glossário A–Z</h1>

      <div className="mt-4 flex flex-wrap gap-2">
        <a
          href="/glossario"
          className={`rounded-full border px-3 py-1 text-xs font-medium ${
            !categoria
              ? "border-black bg-black text-white dark:border-white dark:bg-white dark:text-black"
              : "border-black/15 dark:border-white/15"
          }`}
        >
          Todas
        </a>
        {categories.map((category) => (
          <a
            key={category.id}
            href={`/glossario?categoria=${category.slug}`}
            className={`rounded-full border px-3 py-1 text-xs font-medium ${
              categoria === category.slug
                ? "text-white"
                : "border-black/15 dark:border-white/15"
            }`}
            style={
              categoria === category.slug
                ? { backgroundColor: category.cor, borderColor: category.cor }
                : undefined
            }
          >
            {category.nome}
          </a>
        ))}
      </div>

      {letters.length === 0 && (
        <p className="mt-8 text-sm text-zinc-500 dark:text-zinc-400">
          Nenhum termo encontrado com esse filtro.
        </p>
      )}

      <div className="mt-10 flex flex-col gap-10">
        {letters.map((letter) => (
          <section key={letter}>
            <h2 className="text-lg font-semibold text-zinc-400 dark:text-zinc-500">
              {letter}
            </h2>
            <div className="mt-3 grid gap-3 sm:grid-cols-2">
              {grouped[letter].map((term) => (
                <TermCard key={term.id} term={term} />
              ))}
            </div>
          </section>
        ))}
      </div>
    </main>
  );
}
