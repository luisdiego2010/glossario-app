-- Glossário Colaborativo — dados seed (categorias + ~31 termos + relações)
-- Rode DEPOIS de supabase/migrations/0001_init.sql

-- ---------------------------------------------------------------------------
-- Categorias (Tabela 1 do blueprint)
-- ---------------------------------------------------------------------------
insert into categories (slug, nome, descricao, cor) values
  ('tecnologia-desenvolvimento', 'Tecnologia & Desenvolvimento', 'Termos do dia a dia de desenvolvimento web, APIs e infraestrutura.', '#2563eb'),
  ('inteligencia-artificial', 'Inteligência Artificial', 'Vocabulário de LLMs, agentes, protocolos e engenharia de prompt.', '#7c3aed'),
  ('negocios-produto', 'Negócios & Produto', 'Termos de modelo de negócio, produto e métricas.', '#16a34a'),
  ('saude-seguranca-paciente', 'Saúde & Segurança do Paciente', 'Vocabulário de anestesiologia e segurança do paciente.', '#e11d48')
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Termos — Tecnologia & Desenvolvimento
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('api', 'API', 'Application Programming Interface',
   'Conjunto de regras que permite que dois sistemas conversem entre si, sem que um precise conhecer os detalhes internos do outro.',
   $md$Uma API define quais requisições um sistema aceita e quais respostas devolve — como um contrato. No CuidarSeguro, por exemplo, o frontend em Next.js conversa com o Supabase através de uma API gerada automaticamente (PostgREST) a partir do banco de dados.

**Exemplo prático**: quando um app de clima "busca a previsão", ele está chamando a API de um serviço meteorológico e recebendo os dados de volta, geralmente em formato JSON.$md$,
   'basico'),

  ('sdk', 'SDK', 'Software Development Kit',
   'Um pacote de ferramentas prontas (bibliotecas, exemplos, documentação) que facilita usar uma API ou plataforma sem reescrever tudo do zero.',
   $md$Enquanto a API é o "contrato" de comunicação, o SDK é a caixa de ferramentas que já implementa esse contrato na sua linguagem de programação. O SDK do Supabase para JavaScript, por exemplo, evita que você monte manualmente cada requisição HTTP para o banco.

Nem toda API tem um SDK — algumas exigem que você monte as chamadas manualmente.$md$,
   'basico'),

  ('frontend', 'Frontend', null,
   'A camada de um sistema que roda no navegador (ou app) do usuário e é responsável pela interface visual.',
   $md$É tudo o que o usuário vê e com o que interage diretamente: botões, formulários, animações. No stack usado no CuidarSeguro, o frontend é construído com Next.js e estilizado com Tailwind CSS.

O frontend conversa com o **backend** através de uma API para buscar ou salvar dados.$md$,
   'basico'),

  ('backend', 'Backend', null,
   'A camada de um sistema que roda em um servidor, cuida da lógica de negócio, do banco de dados e não é vista diretamente pelo usuário.',
   $md$O backend recebe requisições do frontend, processa regras de negócio (ex.: "este usuário pode ver este dado?") e fala com o banco de dados. No Supabase, boa parte do backend tradicional (autenticação, API, banco) já vem pronta como serviço.

Um mesmo sistema pode ter frontend e backend no mesmo repositório (como costuma acontecer em projetos Next.js) ou em repositórios separados.$md$,
   'basico'),

  ('repositorio', 'Repositório', null,
   'Uma pasta de projeto com todo o histórico de alterações versionado, geralmente hospedada no GitHub ou similar.',
   $md$Um repositório (ou "repo") guarda o código-fonte e o histórico completo de mudanças feitas nele ao longo do tempo, permitindo voltar a versões anteriores, comparar alterações e trabalhar em equipe sem sobrescrever o trabalho de outra pessoa.

Ferramenta associada: **Git** (o sistema de versionamento) e **GitHub** (o serviço que hospeda repositórios na nuvem).$md$,
   'basico'),

  ('deploy', 'Deploy', null,
   'O ato de publicar uma versão do código em um ambiente acessível publicamente (produção).',
   $md$Fazer deploy é levar o código do seu computador (ou do repositório) para um servidor onde os usuários reais conseguem acessá-lo. Na Vercel, por exemplo, cada push no repositório pode disparar um deploy automático — é o mesmo fluxo usado no CuidarSeguro.

Deploys podem ser manuais ou automatizados via **CI/CD**.$md$,
   'basico'),

  ('webhook', 'Webhook', null,
   'Uma forma de um sistema avisar outro automaticamente quando algo acontece, enviando uma requisição HTTP no momento do evento.',
   $md$Diferente de uma API que você chama quando precisa de algo, um webhook é o outro sistema que te avisa quando algo muda — por exemplo, o Stripe pode enviar um webhook para o seu backend assim que um pagamento é confirmado, sem que você precise ficar perguntando "já pagou? já pagou?" repetidamente.

É a base de integrações em tempo real entre sistemas diferentes.$md$,
   'intermediario'),

  ('ci-cd', 'CI/CD', 'Continuous Integration / Continuous Deployment',
   'Prática de automatizar testes e publicação de código a cada alteração enviada ao repositório, reduzindo erros manuais.',
   $md$**CI (Integração Contínua)** roda testes automaticamente a cada alteração no código, pegando erros cedo. **CD (Deploy Contínuo)** publica essa alteração automaticamente depois que os testes passam.

Um pipeline de CI/CD típico: você dá push no **repositório** → os testes rodam → se passarem, o **deploy** acontece sozinho.$md$,
   'intermediario'),

  ('framework', 'Framework', null,
   'Uma estrutura de código pré-organizada que impõe convenções e resolve problemas comuns, para você não reinventar a roda a cada projeto.',
   $md$Um framework já decide boa parte da estrutura do projeto por você — como organizar pastas, como lidar com rotas, como renderizar páginas. Next.js é um framework de **frontend**/**backend** para React; ele resolve roteamento, renderização no servidor e build, entre outras coisas.

A vantagem é produtividade e convenções compartilhadas; a desvantagem é menos liberdade para fazer diferente do que o framework espera.$md$,
   'basico')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'tecnologia-desenvolvimento') as c;

-- ---------------------------------------------------------------------------
-- Termos — Inteligência Artificial
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('llm', 'LLM', 'Large Language Model',
   'Um modelo de inteligência artificial treinado em enormes quantidades de texto, capaz de gerar e entender linguagem natural.',
   $md$Modelos como o Claude são LLMs: redes neurais treinadas para prever a próxima palavra (mais precisamente, o próximo **token**) de um texto, o que na prática os torna capazes de conversar, escrever código, resumir documentos e muito mais.

Um LLM sozinho não "sabe" nada sobre seus arquivos ou sistemas privados — para isso, ele precisa de ferramentas como **RAG** ou **MCP**.$md$,
   'basico'),

  ('mcp', 'MCP', 'Model Context Protocol',
   'Um protocolo aberto que permite que assistentes de IA se conectem a ferramentas e fontes de dados externas de forma padronizada.',
   $md$O MCP funciona como uma **API** pensada especificamente para IA: em vez de cada assistente precisar de uma integração customizada com cada ferramenta, o MCP define um padrão comum. É assim que o Claude Code, por exemplo, consegue ler arquivos, rodar comandos e acessar serviços externos de forma estruturada.

Pense nele como um "USB-C para IA" — uma porta padrão que qualquer ferramenta compatível pode usar.$md$,
   'intermediario'),

  ('rag', 'RAG', 'Retrieval-Augmented Generation',
   'Técnica que busca informações relevantes em uma base de dados externa antes de gerar uma resposta, tornando o LLM mais preciso e atualizado.',
   $md$Como um **LLM** só sabe o que aprendeu durante o treinamento, o RAG resolve o problema de informação desatualizada ou privada: antes de responder, o sistema busca ("retrieval") documentos relevantes — de um banco de dados, uma wiki, um vault do Obsidian — e inclui esse conteúdo no prompt para o modelo gerar ("generation") uma resposta fundamentada neles.

É a técnica por trás de muitos assistentes que "conhecem" a documentação interna de uma empresa.$md$,
   'intermediario'),

  ('prompt-engineering', 'Prompt Engineering', null,
   'A prática de estruturar instruções para um modelo de IA de forma a obter respostas mais precisas e úteis.',
   $md$Prompt engineering é escrever (e refinar) o pedido feito a um **LLM** com clareza suficiente para reduzir ambiguidade: dar contexto, exemplos, formato de saída esperado, restrições. Um bom prompt costuma valer mais do que trocar de modelo.

Não é uma "linguagem de programação" — é mais próximo de escrever instruções claras para uma pessoa muito capaz, mas sem contexto prévio sobre sua intenção.$md$,
   'basico'),

  ('token', 'Token', null,
   'A menor unidade de texto que um modelo de linguagem processa — pode ser uma palavra, parte de uma palavra ou um caractere de pontuação.',
   $md$Modelos de IA não "leem" texto como nós; eles quebram o texto em tokens e processam essas unidades. Isso importa na prática porque **LLMs** têm um limite de tokens por conversa (a "janela de contexto") e muitos serviços cobram por token processado.

Em português, uma palavra costuma equivaler a 1–2 tokens, em média.$md$,
   'basico'),

  ('fine-tuning', 'Fine-tuning', null,
   'Processo de re-treinar um modelo de IA já existente com dados específicos, para especializá-lo em uma tarefa ou domínio.',
   $md$Em vez de treinar um **LLM** do zero (algo extremamente caro), o fine-tuning ajusta um modelo já treinado usando um conjunto menor de dados focado em um domínio específico — por exemplo, um modelo ajustado com terminologia médica para responder melhor perguntas de anestesiologia.

Alternativa mais barata e comum no dia a dia: usar **RAG** ou **prompt engineering** em vez de fine-tuning.$md$,
   'avancado'),

  ('agente-de-ia', 'Agente de IA', null,
   'Um sistema de IA que não apenas responde perguntas, mas toma ações — usando ferramentas, executando tarefas em múltiplas etapas de forma autônoma.',
   $md$Um agente combina um **LLM** com acesso a ferramentas (via **MCP**, por exemplo): ele decide quais passos tomar, executa ações reais (ler um arquivo, rodar um comando, consultar um banco de dados) e ajusta o plano conforme os resultados. O Claude Code é um exemplo de agente de IA voltado a tarefas de programação.

A diferença central para um chatbot comum é a capacidade de agir no mundo, não só de responder em texto.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'inteligencia-artificial') as c;

-- ---------------------------------------------------------------------------
-- Termos — Negócios & Produto
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('saas', 'SaaS', 'Software as a Service',
   'Modelo de negócio em que o software é acessado pela internet mediante assinatura, sem que o cliente precise instalar ou manter nada.',
   $md$Em vez de comprar uma licença e instalar um programa, o cliente de um SaaS paga (geralmente por mês) para usar o software direto do navegador, enquanto a empresa cuida de hospedagem, atualizações e manutenção. O CuidarSeguro é um exemplo de SaaS.

Um SaaS típico expõe funcionalidades através de uma **API** e é hospedado como uma aplicação web comum (frontend + backend).$md$,
   'basico'),

  ('crm', 'CRM', 'Customer Relationship Management',
   'Sistema usado para organizar e acompanhar o relacionamento de uma empresa com seus clientes e potenciais clientes.',
   $md$Um CRM centraliza informações de contato, histórico de interações, negociações em andamento e status de cada cliente — evitando que essas informações fiquem espalhadas em planilhas ou na memória de quem atende.

Muitos SaaS de nicho, como o CuidarSeguro, podem ter (ou evoluir para ter) funcionalidades de CRM para acompanhar clientes/instituições atendidas.$md$,
   'basico'),

  ('b2b', 'B2B', 'Business to Business',
   'Modelo de negócio em que uma empresa vende produtos ou serviços para outras empresas, não diretamente para o consumidor final.',
   $md$Vendas B2B costumam ter ciclo de decisão mais longo, envolver múltiplas pessoas na aprovação de compra e contratos maiores. Um SaaS de gestão hospitalar vendido para clínicas é um exemplo de B2B.

Contraste com **B2C**, onde a venda é direta ao consumidor final.$md$,
   'basico'),

  ('b2c', 'B2C', 'Business to Consumer',
   'Modelo de negócio em que uma empresa vende produtos ou serviços diretamente para o consumidor final, sem intermediários empresariais.',
   $md$Compras B2C costumam ter ciclo de decisão curto e volume alto de clientes individuais — um app de delivery de comida é B2C.

Contraste com **B2B**, onde o comprador é outra empresa.$md$,
   'basico'),

  ('mvp', 'MVP', 'Minimum Viable Product',
   'A versão mais simples possível de um produto que ainda entrega valor real, usada para validar uma ideia antes de investir mais.',
   $md$Um MVP não é "um produto incompleto" — é um produto completo o suficiente para testar a hipótese central com usuários reais, com o menor esforço possível. O objetivo é aprender rápido e barato antes de construir todas as funcionalidades imaginadas.

A mesma lógica de "fazer o mínimo necessário, mas fazer bem" aparece em outros contextos, como no **Checklist Cirúrgico** — uma lista mínima e objetiva que garante segurança sem burocracia excessiva.$md$,
   'basico'),

  ('kpi', 'KPI', 'Key Performance Indicator',
   'Uma métrica específica usada para medir se um objetivo de negócio está sendo alcançado.',
   $md$Um KPI traduz uma meta vaga ("crescer") em um número acompanhável (ex.: "número de assinantes ativos por mês"). Bons KPIs são poucos, claros e ligados diretamente a uma decisão que a empresa vai tomar com base neles.

Exemplos comuns: número de usuários ativos, taxa de conversão, **churn**.$md$,
   'basico'),

  ('churn', 'Churn', null,
   'A taxa de clientes que cancelam ou deixam de usar um produto em um determinado período.',
   $md$Churn é geralmente calculado como a porcentagem de clientes (ou receita) perdidos em um mês ou ano. É um dos **KPIs** mais observados em negócios de assinatura (**SaaS**), porque conquistar um cliente novo costuma custar mais caro do que manter um existente.

Churn alto pode indicar problemas de produto, preço ou expectativa mal alinhada na venda.$md$,
   'intermediario'),

  ('bau', 'BAU', 'Business As Usual',
   'Expressão que descreve a operação normal e rotineira de um negócio, sem mudanças ou eventos excepcionais.',
   $md$"Voltar ao BAU" significa retomar as operações padrão depois de um evento fora da rotina (um lançamento, uma crise, uma migração de sistema). É um termo comum em relatórios e reuniões de status para diferenciar "trabalho excepcional" de "trabalho de manutenção contínua".

Nota: às vezes esse termo é confundido com siglas parecidas em outros contextos — vale sempre conferir a expansão completa antes de assumir o significado.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'negocios-produto') as c;

-- ---------------------------------------------------------------------------
-- Termos — Saúde & Segurança do Paciente
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('asa', 'ASA', 'American Society of Anesthesiologists',
   'Classificação usada para descrever o estado físico de um paciente antes da anestesia, de ASA I (saudável) a ASA VI (morte encefálica, doador de órgãos).',
   $md$A classificação ASA ajuda a equipe a estimar o risco anestésico-cirúrgico de um paciente e a planejar a conduta. Vai de **ASA I** (paciente saudável) até **ASA VI**, com graus intermediários indicando doenças sistêmicas leves, graves ou risco de vida.

É um dos primeiros dados registrados na avaliação pré-anestésica e costuma aparecer junto ao **Checklist Cirúrgico**.$md$,
   'intermediario'),

  ('pacu', 'PACU', 'Post-Anesthesia Care Unit',
   'A unidade de recuperação pós-anestésica, onde o paciente é monitorado logo após a cirurgia até estar estável para alta ou transferência.',
   $md$Na PACU (também chamada de sala de recuperação), a equipe monitora sinais vitais, dor, náusea e nível de consciência enquanto os efeitos da anestesia passam. É uma etapa crítica de segurança do paciente entre o centro cirúrgico e a enfermaria.

Situações como **near miss** e **eventos adversos** são monitorados de perto também nesta fase.$md$,
   'intermediario'),

  ('rcp', 'RCP', 'Reanimação Cardiopulmonar',
   'Conjunto de manobras de emergência (compressões torácicas e ventilação) para tentar restabelecer a circulação e respiração em uma parada cardiorrespiratória.',
   $md$A RCP busca manter o fluxo mínimo de sangue oxigenado para o cérebro e outros órgãos até que a causa da parada seja tratada ou um desfibrilador esteja disponível. É uma das habilidades mais treinadas em simulações de emergência na área da saúde.

Em inglês, o termo equivalente é **CPR** (Cardiopulmonary Resuscitation).$md$,
   'basico'),

  ('iot-intubacao', 'IOT', 'Intubação Orotraqueal',
   'Procedimento de inserir um tubo pela boca até a traqueia para garantir uma via aérea segura, geralmente durante anestesia geral ou emergências.',
   $md$A IOT garante que o paciente respire adequadamente quando ele não consegue proteger a própria via aérea — seja por estar sob efeito de anestesia geral, seja em uma emergência respiratória.

**Atenção à ambiguidade**: fora da área da saúde, a sigla "IoT" quase sempre significa *Internet of Things* (Internet das Coisas). O contexto da frase é o que diferencia os dois significados — exatamente o tipo de confusão que este glossário existe para resolver.$md$,
   'intermediario'),

  ('near-miss', 'Near miss', 'Quase-erro',
   'Um evento que poderia ter causado dano ao paciente, mas foi interceptado a tempo — sem consequência real.',
   $md$Um near miss é um alerta valioso: mostra uma falha no processo antes que ela cause dano de verdade. Registrar e analisar esses quase-erros (sem punir quem relatou) é uma prática central em cultura de segurança do paciente, permitindo corrigir a causa raiz antes que vire um **evento adverso**.

Exemplo: perceber, antes da indução anestésica, que o paciente errado estava na sala — e corrigir antes de qualquer procedimento.$md$,
   'intermediario'),

  ('checklist-cirurgico', 'Checklist Cirúrgico', 'Lista de verificação de segurança cirúrgica (OMS)',
   'Uma lista curta de verificações obrigatórias, feita em voz alta pela equipe em momentos-chave da cirurgia, para reduzir erros evitáveis.',
   $md$Criado com base em recomendações da OMS, o checklist é dividido em três momentos: antes da indução anestésica, antes da incisão cirúrgica e antes do paciente sair da sala. Confirma itens como identidade do paciente, sítio cirúrgico correto, alergias e contagem de materiais.

É um exemplo de como um processo simples e objetivo — parecido em espírito a um **MVP** bem definido — pode reduzir drasticamente riscos evitáveis.$md$,
   'basico'),

  ('evento-adverso', 'Evento Adverso', null,
   'Um dano não intencional ao paciente causado pelo cuidado prestado (e não pela doença de base), que poderia ter sido evitado.',
   $md$Diferente do **near miss** (que não chega a causar dano), o evento adverso já resultou em prejuízo real ao paciente — desde algo leve e reversível até consequências graves. A análise desses eventos foca em identificar falhas de processo, não em culpar indivíduos, para prevenir recorrência.

Sistemas de notificação de eventos adversos alimentam a melhoria contínua dos protocolos de segurança, incluindo o próprio **Checklist Cirúrgico**.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'saude-seguranca-paciente') as c;

-- ---------------------------------------------------------------------------
-- Relações entre termos ("veja também" — o coração da experiência wiki)
-- ---------------------------------------------------------------------------
insert into term_relations (term_id, related_term_id, tipo_relacao)
select t1.id, t2.id, v.tipo::term_relation_tipo
from (values
  -- Tecnologia
  ('api', 'sdk', 'relacionado'), ('sdk', 'api', 'relacionado'),
  ('api', 'webhook', 'relacionado'), ('webhook', 'api', 'relacionado'),
  ('api', 'mcp', 'relacionado'), ('mcp', 'api', 'relacionado'),
  ('sdk', 'framework', 'relacionado'), ('framework', 'sdk', 'relacionado'),
  ('frontend', 'backend', 'relacionado'), ('backend', 'frontend', 'relacionado'),
  ('backend', 'api', 'relacionado'), ('api', 'backend', 'relacionado'),
  ('repositorio', 'ci-cd', 'pre_requisito'), ('ci-cd', 'repositorio', 'relacionado'),
  ('ci-cd', 'deploy', 'relacionado'), ('deploy', 'ci-cd', 'relacionado'),
  ('framework', 'backend', 'relacionado'), ('backend', 'framework', 'relacionado'),
  ('framework', 'frontend', 'relacionado'), ('frontend', 'framework', 'relacionado'),

  -- Inteligência Artificial
  ('llm', 'mcp', 'relacionado'), ('mcp', 'llm', 'relacionado'),
  ('llm', 'token', 'pre_requisito'), ('token', 'llm', 'relacionado'),
  ('llm', 'fine-tuning', 'relacionado'), ('fine-tuning', 'llm', 'relacionado'),
  ('llm', 'rag', 'relacionado'), ('rag', 'llm', 'relacionado'),
  ('rag', 'mcp', 'relacionado'), ('mcp', 'rag', 'relacionado'),
  ('prompt-engineering', 'llm', 'relacionado'), ('llm', 'prompt-engineering', 'relacionado'),
  ('agente-de-ia', 'mcp', 'relacionado'), ('mcp', 'agente-de-ia', 'relacionado'),
  ('agente-de-ia', 'llm', 'pre_requisito'), ('llm', 'agente-de-ia', 'relacionado'),

  -- Negócios
  ('saas', 'crm', 'relacionado'), ('crm', 'saas', 'relacionado'),
  ('saas', 'mvp', 'relacionado'), ('mvp', 'saas', 'relacionado'),
  ('saas', 'api', 'veja_tambem'), ('api', 'saas', 'veja_tambem'),
  ('crm', 'b2b', 'relacionado'), ('b2b', 'crm', 'relacionado'),
  ('b2b', 'b2c', 'relacionado'), ('b2c', 'b2b', 'relacionado'),
  ('mvp', 'kpi', 'relacionado'), ('kpi', 'mvp', 'relacionado'),
  ('kpi', 'churn', 'relacionado'), ('churn', 'kpi', 'relacionado'),
  ('churn', 'bau', 'veja_tambem'), ('bau', 'churn', 'veja_tambem'),
  ('bau', 'near-miss', 'veja_tambem'), ('near-miss', 'bau', 'veja_tambem'),
  ('mvp', 'checklist-cirurgico', 'veja_tambem'), ('checklist-cirurgico', 'mvp', 'veja_tambem'),

  -- Saúde
  ('asa', 'pacu', 'relacionado'), ('pacu', 'asa', 'relacionado'),
  ('pacu', 'rcp', 'relacionado'), ('rcp', 'pacu', 'relacionado'),
  ('rcp', 'iot-intubacao', 'relacionado'), ('iot-intubacao', 'rcp', 'relacionado'),
  ('near-miss', 'evento-adverso', 'relacionado'), ('evento-adverso', 'near-miss', 'relacionado'),
  ('evento-adverso', 'checklist-cirurgico', 'relacionado'), ('checklist-cirurgico', 'evento-adverso', 'relacionado'),
  ('checklist-cirurgico', 'asa', 'relacionado'), ('asa', 'checklist-cirurgico', 'relacionado'),
  ('near-miss', 'checklist-cirurgico', 'veja_tambem'), ('checklist-cirurgico', 'near-miss', 'veja_tambem')
) as v(term_slug, related_slug, tipo)
join terms t1 on t1.slug = v.term_slug
join terms t2 on t2.slug = v.related_slug
on conflict do nothing;
