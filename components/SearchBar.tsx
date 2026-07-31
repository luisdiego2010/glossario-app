"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export function SearchBar({ defaultValue = "" }: { defaultValue?: string }) {
  const [query, setQuery] = useState(defaultValue);
  const router = useRouter();

  return (
    <form
      role="search"
      onSubmit={(e) => {
        e.preventDefault();
        const trimmed = query.trim();
        if (trimmed) router.push(`/buscar?q=${encodeURIComponent(trimmed)}`);
      }}
      className="flex w-full max-w-xl gap-2"
    >
      <input
        type="search"
        name="q"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Buscar termo: SaaS, MCP, PACU..."
        className="w-full rounded-md border border-black/15 bg-white px-4 py-2.5 text-sm outline-none focus:border-black/40 dark:border-white/15 dark:bg-black dark:focus:border-white/40"
      />
      <button
        type="submit"
        className="shrink-0 rounded-md bg-zinc-900 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-zinc-700 dark:bg-white dark:text-black dark:hover:bg-zinc-200"
      >
        Buscar
      </button>
    </form>
  );
}
