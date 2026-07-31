export type TermNivel = "basico" | "intermediario" | "avancado";
export type TermStatus = "rascunho" | "publicado";
export type TermRelationTipo = "relacionado" | "pre_requisito" | "veja_tambem";

export type Category = {
  id: string;
  slug: string;
  nome: string;
  descricao: string | null;
  cor: string;
};

export type Term = {
  id: string;
  slug: string;
  termo: string;
  expansao: string | null;
  definicao_curta: string;
  definicao_completa: string;
  category_id: string;
  nivel: TermNivel;
  fontes: string[];
  status: TermStatus;
  created_at: string;
  updated_at: string;
};

export type TermWithCategory = Term & {
  category: Category;
};

export type TermRelation = {
  term_id: string;
  related_term_id: string;
  tipo_relacao: TermRelationTipo;
};

export type RelatedTerm = {
  slug: string;
  termo: string;
  definicao_curta: string;
  tipo_relacao: TermRelationTipo;
};
