import type { Metadata } from "next";

export const metadata: Metadata = { title: "Admin" };

export default function AdminPage() {
  return (
    <main className="mx-auto w-full max-w-2xl flex-1 px-6 py-16">
      <h1 className="text-2xl font-semibold tracking-tight">Admin</h1>
      <p className="mt-4 text-zinc-600 dark:text-zinc-400">
        Painel de cadastro/edição de termos ainda não implementado. Segundo o
        blueprint (Seção 6.1), o plano é protegê-lo com Supabase Auth (login
        único, seu) e oferecer um formulário para criar/editar termos e marcar
        relações. Por enquanto, edite os termos diretamente via SQL em{" "}
        <code>supabase/seed/0001_terms_seed.sql</code> ou pelo Table Editor do
        Supabase.
      </p>
    </main>
  );
}
