"use client";

import { useActionState } from "react";
import { createTerm, type NewTermState } from "@/app/admin/actions";

const inputClass =
  "w-full rounded-md border border-black/15 bg-white px-4 py-2.5 text-sm outline-none focus:border-black/40 dark:border-white/15 dark:bg-black dark:focus:border-white/40";
const labelClass = "text-sm font-medium";

export function NewTermForm({
  categories,
}: {
  categories: { id: string; nome: string }[];
}) {
  const [state, action, pending] = useActionState<NewTermState, FormData>(
    createTerm,
    undefined
  );

  return (
    <form action={action} className="mt-8 flex flex-col gap-4">
      <div className="flex flex-col gap-1">
        <label htmlFor="termo" className={labelClass}>
          Termo
        </label>
        <input id="termo" name="termo" required className={inputClass} />
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="expansao" className={labelClass}>
          Expansão da sigla (opcional)
        </label>
        <input
          id="expansao"
          name="expansao"
          placeholder="Ex.: Minimum Viable Product"
          className={inputClass}
        />
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="definicao_curta" className={labelClass}>
          Definição curta
        </label>
        <input
          id="definicao_curta"
          name="definicao_curta"
          required
          className={inputClass}
        />
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="definicao_completa" className={labelClass}>
          Definição completa (aceita Markdown)
        </label>
        <textarea
          id="definicao_completa"
          name="definicao_completa"
          required
          rows={6}
          className={inputClass}
        />
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="category_id" className={labelClass}>
          Categoria
        </label>
        <select
          id="category_id"
          name="category_id"
          required
          className={inputClass}
        >
          <option value="">Selecione...</option>
          {categories.map((category) => (
            <option key={category.id} value={category.id}>
              {category.nome}
            </option>
          ))}
        </select>
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="nivel" className={labelClass}>
          Nível
        </label>
        <select
          id="nivel"
          name="nivel"
          defaultValue="basico"
          className={inputClass}
        >
          <option value="basico">Básico</option>
          <option value="intermediario">Intermediário</option>
          <option value="avancado">Avançado</option>
        </select>
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="link_wiki" className={labelClass}>
          Link de referência (Wikipédia)
        </label>
        <input
          id="link_wiki"
          name="link_wiki"
          type="url"
          placeholder="https://pt.wikipedia.org/wiki/..."
          className={inputClass}
        />
      </div>

      <div className="flex flex-col gap-1">
        <label htmlFor="status" className={labelClass}>
          Status
        </label>
        <select
          id="status"
          name="status"
          defaultValue="publicado"
          className={inputClass}
        >
          <option value="publicado">Publicado (aparece no site)</option>
          <option value="rascunho">Rascunho (fica oculto)</option>
        </select>
      </div>

      {state?.error && <p className="text-sm text-red-600">{state.error}</p>}

      <button
        type="submit"
        disabled={pending}
        className="rounded-md bg-zinc-900 px-4 py-2.5 text-sm font-medium text-white transition-colors hover:bg-zinc-700 disabled:opacity-50 dark:bg-white dark:text-black dark:hover:bg-zinc-200"
      >
        {pending ? "Salvando..." : "Salvar termo"}
      </button>
    </form>
  );
}
