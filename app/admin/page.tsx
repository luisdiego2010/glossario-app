import type { Metadata } from "next";
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
        Logado como <strong>{user.email}</strong>. Segundo o blueprint
        (Seção 6.1), o próximo passo é o formulário de criar/editar termos e
        marcar relações. Por enquanto, edite os termos diretamente via SQL em{" "}
        <code>supabase/seed/0001_terms_seed.sql</code> ou pelo Table Editor do
        Supabase.
      </p>
    </main>
  );
}
