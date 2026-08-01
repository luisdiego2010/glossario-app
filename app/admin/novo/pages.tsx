import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { NewTermForm } from "./NewTermForm";

export const metadata: Metadata = { title: "Novo termo" };

export default async function NovoTermoPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: categories } = await supabase
    .from("categories")
    .select("id, nome")
    .order("nome");

  return (
    <main className="mx-auto w-full max-w-2xl flex-1 px-6 py-16">
      <Link
        href="/admin"
        className="text-sm text-zinc-600 hover:underline dark:text-zinc-400"
      >
        ← Admin
      </Link>
      <h1 className="mt-2 text-2xl font-semibold tracking-tight">
        Novo termo
      </h1>
      <NewTermForm categories={categories ?? []} />
    </main>
  );
}
