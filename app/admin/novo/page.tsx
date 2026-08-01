import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { logout } from "@/app/login/actions";

export const metadata: Metadata = { title: "Admin" };

export default async function AdminPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: terms } = await supabase
    .from("terms")
    .select("id, termo, status, category:categories(nome)")
    .order("created_at", { ascending: false });

  return (
    <main className="mx-auto w-full max-w-2xl flex-1 px-6 py-16">
      <div className="flex items-center justify-between gap-4">
        <h1 className="text-2xl font-semibold tracking-tight">Admin</h1>
        <form action={logout}>
          <button
            type="submit"
            className="text-sm font-medium text-zinc-600 underline-offset-4 hover:underline dark:text-zinc-400"
          >
            Sair
          </button>
        </form>
      </div>
      <p className="mt-4 text-zinc-600 dark:text-zinc-400">
        Logado como <strong>{user.email}</strong>.
      </p>

      <Link
        href="/admin/novo"
        className="mt-6 inline-block rounded-md bg-zinc-900 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-zinc-700 dark:bg-white dark:text-black dark:hover:bg-zinc-200"
      >
        + Novo termo
      </Link>

      <ul className="mt-8 divide-y divide-black/10 dark:divide-white/10">
        {(terms ?? []).map((term) => {
          const category = term.category as unknown as { nome: string } | null;
          return (
            <li
              key={term.id}
              className="flex items-center justify-between gap-4 py-3 text-sm"
            >
              <div>
                <span className="font-medium">{term.termo}</span>
                {category && (
                  <span className="ml-2 text-zinc-500 dark:text-zinc-400">
                    {category.nome}
                  </span>
                )}
              </div>
              <span
                className={
                  term.status === "publicado"
                    ? "text-green-600 dark:text-green-400"
                    : "text-zinc-500 dark:text-zinc-400"
                }
              >
                {term.status}
              </span>
            </li>
          );
        })}
        {(!terms || terms.length === 0) && (
          <li className="py-3 text-sm text-zinc-500 dark:text-zinc-400">
            Nenhum termo cadastrado ainda.
          </li>
        )}
      </ul>
    </main>
  );
}
