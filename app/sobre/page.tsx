import type { Metadata } from "next";

export const metadata: Metadata = { title: "Sobre" };

export default function SobrePage() {
  return (
    <main className="mx-auto w-full max-w-2xl flex-1 px-6 py-16">
      <h1 className="text-2xl font-semibold tracking-tight">Sobre</h1>
      <div className="prose prose-zinc mt-6 max-w-none dark:prose-invert">
        <p>
          Este glossário nasceu de um problema simples: tecnologia,
          inteligência artificial e negócios são cheios de siglas que
          aparecem sem explicação em artigos, documentações e conversas com
          ferramentas de IA — e o mesmo acontece com o vocabulário técnico da
          área da saúde.
        </p>
        <p>
          Em vez de buscar cada termo isoladamente a cada vez, este é um
          glossário curado, estruturado como uma wiki: cada termo linka para
          termos relacionados, permitindo navegar por associação, não só por
          busca.
        </p>
        <p>
          É um projeto pessoal, em construção contínua, relacionado a outros
          projetos como o{" "}
          <a href="https://www.cuidarseguro.com.br" target="_blank" rel="noopener noreferrer">
            CuidarSeguro
          </a>
          .
        </p>
        <h2>Fontes e referências</h2>
        <p>
          As definições deste glossário foram compiladas com apoio de IA a
          partir de conhecimento geral, documentação técnica e verbetes de
          referência como a Wikipédia — não são citações diretas de uma fonte
          única por termo. Quando um termo tem um link de referência, ele foi
          conferido manualmente antes de ser publicado, mas o texto da
          definição em si é uma síntese, não uma tradução ou cópia.
        </p>
        <p>
          Para os termos de saúde e segurança do paciente em especial, este
          glossário é material de estudo geral e não substitui protocolos
          institucionais, bulas ou a orientação de um profissional
          qualificado.
        </p>
      </div>
    </main>
  );
}
