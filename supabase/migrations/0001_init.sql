-- Glossário Colaborativo — schema inicial (MVP)
-- Tabelas: categories, terms, term_relations
-- Ref.: Seção 3 do blueprint (Documento de Estrutura de Projeto)

create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------------
-- categories
-- ---------------------------------------------------------------------------
create table categories (
  id          uuid primary key default gen_random_uuid(),
  slug        text not null unique,
  nome        text not null,
  descricao   text,
  cor         text not null
);

comment on table categories is 'Domínios do glossário: Tecnologia, IA, Negócios, Saúde.';

-- ---------------------------------------------------------------------------
-- terms
-- ---------------------------------------------------------------------------
create type term_nivel as enum ('basico', 'intermediario', 'avancado');
create type term_status as enum ('rascunho', 'publicado');

create table terms (
  id                  uuid primary key default gen_random_uuid(),
  slug                text not null unique,
  termo               text not null,
  expansao            text,
  definicao_curta     text not null,
  definicao_completa  text not null,
  category_id         uuid not null references categories (id) on delete restrict,
  nivel               term_nivel not null default 'basico',
  fontes              jsonb not null default '[]'::jsonb,
  status              term_status not null default 'rascunho',
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now(),
  search_vector       tsvector generated always as (
    setweight(to_tsvector('portuguese', coalesce(termo, '')), 'A') ||
    setweight(to_tsvector('portuguese', coalesce(expansao, '')), 'B') ||
    setweight(to_tsvector('portuguese', coalesce(definicao_curta, '')), 'B') ||
    setweight(to_tsvector('portuguese', coalesce(definicao_completa, '')), 'C')
  ) stored
);

create index terms_search_vector_idx on terms using gin (search_vector);
create index terms_category_id_idx on terms (category_id);

create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger terms_set_updated_at
  before update on terms
  for each row
  execute function set_updated_at();

-- ---------------------------------------------------------------------------
-- term_relations ("veja também" / pré-requisito)
-- ---------------------------------------------------------------------------
create type term_relation_tipo as enum ('relacionado', 'pre_requisito', 'veja_tambem');

create table term_relations (
  term_id         uuid not null references terms (id) on delete cascade,
  related_term_id uuid not null references terms (id) on delete cascade,
  tipo_relacao    term_relation_tipo not null default 'relacionado',
  primary key (term_id, related_term_id),
  check (term_id <> related_term_id)
);

create index term_relations_related_term_id_idx on term_relations (related_term_id);

-- ---------------------------------------------------------------------------
-- Row Level Security
-- Leitura pública apenas de termos publicados; escrita restrita a usuários
-- autenticados (você, via Supabase Auth) até existir um fluxo de contribuição.
-- ---------------------------------------------------------------------------
alter table categories enable row level security;
alter table terms enable row level security;
alter table term_relations enable row level security;

create policy "categorias são públicas"
  on categories for select
  using (true);

create policy "termos publicados são públicos"
  on terms for select
  using (status = 'publicado');

create policy "usuários autenticados leem todos os termos"
  on terms for select
  to authenticated
  using (true);

create policy "usuários autenticados gerenciam termos"
  on terms for all
  to authenticated
  using (true)
  with check (true);

create policy "usuários autenticados gerenciam categorias"
  on categories for all
  to authenticated
  using (true)
  with check (true);

create policy "relações de termos publicados são públicas"
  on term_relations for select
  using (
    exists (
      select 1 from terms
      where terms.id = term_relations.term_id
        and terms.status = 'publicado'
    )
  );

create policy "usuários autenticados leem todas as relações"
  on term_relations for select
  to authenticated
  using (true);

create policy "usuários autenticados gerenciam relações"
  on term_relations for all
  to authenticated
  using (true)
  with check (true);
