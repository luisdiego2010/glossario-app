-- Glossário Colaborativo — segundo lote de termos (32 novos, 8 por categoria)
-- Rode DEPOIS de supabase/seed/0001_terms_seed.sql e 0002_fontes_termos.sql
-- Fontes ficam vazias aqui de propósito — ver supabase/seed/0004_fontes_novos_termos.sql

-- ---------------------------------------------------------------------------
-- Termos — Tecnologia & Desenvolvimento
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('container', 'Contêiner', null,
   'Uma forma de empacotar uma aplicação com tudo que ela precisa pra rodar (código, bibliotecas, configurações), isolada do resto do sistema operacional.',
   $md$Diferente de uma máquina virtual completa, um contêiner compartilha o kernel do sistema operacional host, o que o torna muito mais leve e rápido de iniciar. A ferramenta mais conhecida pra isso é o Docker.

**Exemplo prático**: um contêiner pode empacotar exatamente a versão do Node.js e das dependências que um projeto usa, garantindo que ele rode do mesmo jeito na máquina de um desenvolvedor e em produção.$md$,
   'basico'),

  ('middleware', 'Middleware', null,
   'Uma camada de código que intercepta requisições entre o cliente e a lógica principal de uma aplicação, pra rodar alguma verificação ou transformação no meio do caminho.',
   $md$Middleware roda "no meio do caminho" de uma requisição: antes dela chegar na página ou API final, dá pra checar autenticação, redirecionar, ou modificar cabeçalhos.

No Next.js (a partir da versão 16, esse arquivo se chama `proxy.ts`), é exatamente esse padrão que protege o `/admin` deste site: antes de qualquer página daquela pasta renderizar, o middleware verifica se existe uma sessão válida e redireciona pro login se não houver.$md$,
   'intermediario'),

  ('orm', 'ORM', 'Object-Relational Mapping',
   'Uma camada que traduz objetos do código para linhas de tabelas do banco de dados (e vice-versa), evitando escrever SQL manualmente pra operações comuns.',
   $md$Um ORM permite escrever algo como `usuario.save()` em vez de montar um `INSERT INTO` manualmente. Facilita o dia a dia, mas pode esconder detalhes de performance que um SQL escrito à mão deixaria mais claros.

Este projeto não usa um ORM tradicional — ele conversa com o Postgres através do PostgREST do Supabase, que gera uma API REST diretamente a partir do schema do banco.$md$,
   'intermediario'),

  ('cdn', 'CDN', 'Content Delivery Network',
   'Uma rede de servidores espalhados geograficamente que entrega arquivos estáticos (imagens, scripts, páginas) a partir do ponto mais próximo do usuário, reduzindo a latência.',
   $md$Em vez de todo mundo no mundo buscar um arquivo do mesmo servidor central, uma CDN guarda cópias desse arquivo em vários pontos ao redor do globo (edge locations) e serve a cópia mais próxima de quem está pedindo.

Plataformas como a Vercel (usada para hospedar este site) publicam automaticamente os arquivos estáticos do Next.js numa CDN, sem configuração extra.$md$,
   'basico'),

  ('oauth', 'OAuth', null,
   'Um protocolo padrão que permite que um app acesse dados de um usuário em outro serviço (como Google ou GitHub) sem que o usuário precise compartilhar sua senha diretamente com o app.',
   $md$Quando você clica em "Entrar com Google" em algum site, é o OAuth funcionando por trás: o site recebe uma permissão temporária e limitada, concedida pelo próprio Google, sem nunca ver sua senha.

O Supabase Auth (usado no login deste site) suporta login com email/senha, como configuramos aqui, mas também permite adicionar provedores OAuth como Google ou GitHub sem muito esforço extra.$md$,
   'intermediario'),

  ('jwt', 'JWT', 'JSON Web Token',
   'Um formato de token compacto e assinado digitalmente, usado pra provar a identidade de um usuário autenticado sem precisar consultar o banco de dados a cada requisição.',
   $md$Um JWT carrega, de forma assinada (não necessariamente criptografada), informações como "este é o usuário X, autenticado até tal horário". Qualquer servidor que confie na assinatura pode validar o token sem bater no banco de dados a cada vez.

É esse mecanismo que o Supabase Auth usa por baixo dos panos para manter você logado no `/admin` deste site entre uma página e outra, através de um cookie de sessão.$md$,
   'intermediario'),

  ('websocket', 'WebSocket', null,
   'Um protocolo que mantém uma conexão aberta entre cliente e servidor, permitindo troca de mensagens em tempo real nos dois sentidos, sem precisar recarregar a página.',
   $md$Diferente de uma requisição HTTP comum (que abre, pede, recebe e fecha a conexão), um WebSocket fica aberto, permitindo que o servidor envie dados pro cliente a qualquer momento — útil para chats, notificações e dashboards ao vivo.

O Supabase Realtime usa WebSockets para avisar um app instantaneamente quando uma linha de uma tabela muda, sem precisar ficar perguntando ("polling") repetidamente.$md$,
   'intermediario'),

  ('serverless', 'Serverless', null,
   'Um modelo de infraestrutura em que o código roda sob demanda em servidores gerenciados pela plataforma, sem que o desenvolvedor precise provisionar ou manter máquinas.',
   $md$"Serverless" não significa que não existem servidores — significa que você não gerencia eles. O provedor sobe uma instância só quando uma requisição chega, e ela desliga (ou hiberna) quando não há uso, cobrando geralmente por execução.

As Server Actions e rotas deste site na Vercel rodam nesse modelo: cada requisição pode ser atendida por uma função que existe só pelo tempo necessário para processá-la.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'tecnologia-desenvolvimento') as c
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Termos — Inteligência Artificial
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('embedding', 'Embedding', null,
   'Uma representação numérica (vetor) de um texto, imagem ou outro dado, na qual itens com significado parecido ficam mais próximos entre si no espaço matemático.',
   $md$Um embedding transforma "cachorro" e "cão" em vetores próximos um do outro, mesmo sendo palavras diferentes, porque capturam significado, não só a grafia.

É essa técnica que permite busca semântica: em vez de procurar só por palavras exatas (como o `search_vector` usado na busca deste glossário), um sistema baseado em embeddings acha resultados parecidos em significado, mesmo com palavras diferentes.$md$,
   'intermediario'),

  ('alucinacao', 'Alucinação', null,
   'Quando um modelo de IA gera uma informação que parece confiante e coerente, mas é factualmente incorreta ou simplesmente inventada.',
   $md$Alucinações acontecem porque um LLM gera texto prevendo a palavra mais provável, não consultando um banco de fatos verificado — então ele pode "inventar" uma fonte, uma citação ou um detalhe que soa plausível, mas não existe.

Foi justamente por causa desse risco que os links de referência deste glossário foram checados manualmente (via busca) antes de serem publicados, em vez de aceitos de olhos fechados.$md$,
   'basico'),

  ('janela-de-contexto', 'Janela de Contexto', 'Context Window',
   'A quantidade máxima de texto (medida em tokens) que um modelo de linguagem consegue "ver" de uma vez, incluindo a conversa inteira e a resposta que ele vai gerar.',
   $md$Quando uma conversa ou documento ultrapassa a janela de contexto de um modelo, informações mais antigas precisam ser resumidas ou descartadas pra caber o que ainda falta processar.

Modelos diferentes têm janelas de tamanhos bem diferentes — de alguns milhares a mais de um milhão de tokens — e isso afeta diretamente quanto texto ou código um assistente de IA consegue considerar de uma vez.$md$,
   'intermediario'),

  ('temperatura', 'Temperatura', null,
   'Um parâmetro que controla o quão aleatória ou previsível é a resposta de um modelo de IA — temperatura baixa gera respostas mais consistentes, temperatura alta gera respostas mais variadas.',
   $md$Tecnicamente, a temperatura ajusta a distribuição de probabilidade sobre a próxima palavra candidata: perto de zero, o modelo quase sempre escolhe a opção mais provável; mais alta, ele passa a considerar opções menos óbvias com mais frequência.

Tarefas que exigem precisão (como gerar código ou responder uma pergunta factual) costumam usar temperatura baixa; tarefas criativas (como brainstorm) se beneficiam de uma temperatura mais alta.$md$,
   'avancado'),

  ('few-shot-learning', 'Few-shot Learning', null,
   'A técnica de incluir alguns exemplos do que se espera diretamente dentro do prompt, em vez de treinar o modelo especificamente para aquela tarefa.',
   $md$Em vez de fazer fine-tuning (que exige re-treinar o modelo com dados próprios), few-shot learning só mostra 2 ou 3 exemplos de entrada e saída desejada no próprio prompt, e o modelo generaliza o padrão a partir daí.

Quando não se dá nenhum exemplo, chama-se "zero-shot"; com um único exemplo, "one-shot". É uma forma rápida e barata de guiar um modelo sem precisar de infraestrutura de treinamento.$md$,
   'avancado'),

  ('transformer', 'Transformer', null,
   'A arquitetura de rede neural, baseada em um mecanismo chamado atenção, que se tornou a base da maioria dos modelos de linguagem modernos.',
   $md$Antes dos Transformers, redes neurais processavam texto palavra por palavra em sequência, o que dificultava capturar relações entre palavras distantes numa frase. O mecanismo de atenção permite que o modelo pese a importância de todas as palavras de uma vez, em paralelo.

Essa arquitetura, apresentada em 2017 num artigo científico do Google, é a base de praticamente todo LLM relevante hoje, incluindo a família Claude.$md$,
   'avancado'),

  ('vies-algoritmico', 'Viés Algorítmico', 'Algorithmic Bias',
   'Quando um sistema de IA reproduz ou amplifica preconceitos presentes nos dados usados para treiná-lo, levando a resultados injustos ou discriminatórios.',
   $md$Como um modelo aprende padrões a partir de dados históricos, ele pode acabar reproduzindo desigualdades que já existiam nesses dados — por exemplo, associando certas profissões predominantemente a um gênero, porque foi assim nos textos usados no treinamento.

Mitigar viés algorítmico exige atenção tanto na escolha e curadoria dos dados de treinamento quanto em testes específicos após o modelo pronto.$md$,
   'intermediario'),

  ('ia-multimodal', 'IA Multimodal', null,
   'Um modelo de IA capaz de entender e/ou gerar mais de um tipo de conteúdo — texto, imagem, áudio ou vídeo — ao mesmo tempo.',
   $md$Um modelo multimodal pode, por exemplo, receber uma foto e uma pergunta em texto sobre ela, e responder em texto — combinando os dois tipos de entrada numa única resposta coerente.

Isso abre casos de uso como descrever uma imagem, ler um gráfico, ou analisar um print de tela de um erro de código.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'inteligencia-artificial') as c
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Termos — Negócios & Produto
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('mrr', 'MRR', 'Monthly Recurring Revenue',
   'A receita recorrente mensal previsível de um negócio de assinatura, somando todas as mensalidades ativas dos clientes.',
   $md$MRR é uma das métricas mais acompanhadas em negócios SaaS porque, diferente de uma venda única, permite prever o faturamento dos próximos meses com razoável confiança — desde que se leve em conta o churn.

Multiplicar o MRR por 12 dá uma aproximação do ARR (receita recorrente anual), outra métrica comum em relatórios de investidores.$md$,
   'intermediario'),

  ('ltv', 'LTV', 'Lifetime Value',
   'O valor total que se espera que um cliente gere de receita durante todo o tempo em que permanece pagando pelo produto.',
   $md$LTV ajuda a responder "quanto vale a pena gastar pra conquistar um cliente?" — normalmente comparado lado a lado com o CAC. Uma relação saudável costuma ser LTV pelo menos 3 vezes maior que o CAC.

Um LTV alto pode vir tanto de um ticket médio maior quanto de um churn mais baixo (o cliente fica mais tempo pagando).$md$,
   'intermediario'),

  ('cac', 'CAC', 'Custo de Aquisição de Cliente',
   'Quanto, em média, uma empresa gasta em marketing e vendas para conquistar um novo cliente.',
   $md$Calcula-se dividindo o total gasto em marketing e vendas num período pelo número de clientes novos conquistados nesse mesmo período. Um CAC alto não é necessariamente ruim, desde que o LTV do cliente compense esse investimento.$md$,
   'basico'),

  ('product-market-fit', 'Product-Market Fit', null,
   'O momento em que um produto atende tão bem a uma necessidade real do mercado que a demanda cresce organicamente, sem esforço forçado de vendas.',
   $md$Antes do product-market fit, cada venda costuma exigir esforço manual e convencimento. Depois dele, o boca a boca e a retenção natural dos clientes começam a puxar o crescimento — um sinal de que vale a pena investir mais em escalar, e não só em ajustar o produto.$md$,
   'intermediario'),

  ('okr', 'OKR', 'Objectives and Key Results',
   'Uma metodologia de definição de metas que conecta um objetivo qualitativo a poucos resultados-chave mensuráveis, usada para alinhar equipes em torno de prioridades.',
   $md$Um Objetivo costuma ser uma frase ambiciosa e inspiradora (ex.: "Ser a referência em glossários técnicos em português"), enquanto os Key Results são números concretos que provam que o objetivo foi alcançado (ex.: "chegar a 100 termos publicados").

Diferente de um KPI, que mede uma métrica contínua do negócio, um OKR costuma ter um prazo definido (trimestre, por exemplo) e é revisto periodicamente.$md$,
   'intermediario'),

  ('roadmap', 'Roadmap', null,
   'Um plano visual que mostra a direção e as prioridades de um produto ao longo do tempo, sem necessariamente prometer datas exatas.',
   $md$Um bom roadmap comunica o "porquê" por trás de cada prioridade, não só uma lista de funcionalidades. Costuma ser organizado por horizonte de tempo (agora, próximo, depois) em vez de datas fixas, justamente porque prioridades de produto mudam com frequência.$md$,
   'basico'),

  ('onboarding', 'Onboarding', null,
   'O processo de guiar um novo usuário (ou funcionário) pelos primeiros passos até ele conseguir extrair valor real do produto — ou começar a trabalhar, no caso de uma contratação.',
   $md$Um onboarding de produto bem feito reduz o abandono logo nos primeiros dias de uso, que costuma ser o momento de maior risco de churn. Pode incluir desde um tour guiado na interface até um checklist de configuração inicial.$md$,
   'basico'),

  ('bootstrapping', 'Bootstrapping', null,
   'Construir e crescer uma empresa usando apenas receita própria e recursos dos fundadores, sem captar investimento externo.',
   $md$Empresas "bootstrapped" mantêm controle total sobre as decisões, mas costumam crescer mais devagar do que empresas que captam investimento, já que reinvestem o próprio lucro em vez de usar capital externo para acelerar.$md$,
   'intermediario')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'negocios-produto') as c
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Termos — Saúde & Segurança do Paciente
-- ---------------------------------------------------------------------------
insert into terms (slug, termo, expansao, definicao_curta, definicao_completa, category_id, nivel, fontes, status)
select v.slug, v.termo, v.expansao, v.definicao_curta, v.definicao_completa, c.id, v.nivel::term_nivel, '[]'::jsonb, 'publicado'
from (values
  ('sedacao', 'Sedação', null,
   'O uso de medicamentos para reduzir a consciência e a ansiedade de um paciente durante um procedimento, em graus que vão do leve ao profundo.',
   $md$A sedação existe num espectro contínuo: da sedação mínima (paciente acordado e responsivo) até a sedação profunda (próxima da anestesia geral, com risco de comprometer a respiração espontânea). O nível escolhido depende do procedimento e do paciente.$md$,
   'basico'),

  ('anestesia-regional', 'Anestesia Regional', null,
   'Uma técnica que bloqueia a sensibilidade de uma parte específica do corpo, injetando anestésico perto de nervos ou da medula espinhal, mantendo o paciente consciente.',
   $md$Exemplos comuns incluem a raquianestesia e a peridural, usadas com frequência em cirurgias ortopédicas e partos. A vantagem, em comparação com a anestesia geral, é evitar os riscos associados à perda total de consciência e ao manejo da via aérea.$md$,
   'intermediario'),

  ('capnografia', 'Capnografia', null,
   'A medição contínua do gás carbônico exalado pelo paciente, usada para monitorar em tempo real se a respiração e a ventilação estão adequadas.',
   $md$A capnografia é considerada um dos monitores mais importantes durante anestesia geral, porque detecta problemas de ventilação (como um tubo mal posicionado) muito antes de uma queda perigosa na oxigenação aparecer em outros monitores.$md$,
   'avancado'),

  ('hipotermia-perioperatoria', 'Hipotermia Perioperatória', null,
   'A queda não intencional da temperatura corporal do paciente antes, durante ou depois de uma cirurgia, associada a mais complicações e recuperação mais lenta.',
   $md$A anestesia geral reduz a capacidade natural do corpo de regular a própria temperatura, e salas de cirurgia costumam ser frias — por isso o aquecimento ativo do paciente (com mantas térmicas, por exemplo) é uma prática padrão de segurança, não só de conforto.$md$,
   'intermediario'),

  ('cultura-de-seguranca', 'Cultura de Segurança do Paciente', null,
   'O conjunto de valores e comportamentos de uma equipe de saúde que prioriza relatar erros abertamente e aprender com eles, em vez de esconder ou punir quem os comete.',
   $md$Numa cultura de segurança madura, um near miss é visto como uma oportunidade valiosa de aprendizado, não como algo a esconder — o que aumenta a chance de erros semelhantes serem evitados no futuro.$md$,
   'intermediario'),

  ('sbar', 'SBAR', 'Situation, Background, Assessment, Recommendation',
   'Um roteiro estruturado de comunicação usado para passar informações críticas de um paciente entre profissionais de forma clara e completa, reduzindo mal-entendidos.',
   $md$SBAR organiza a passagem de caso em quatro blocos: a Situação atual, o Histórico (Background) relevante, a Avaliação (Assessment) de quem está passando o caso, e a Recomendação do que fazer a seguir. É especialmente útil em momentos de troca de plantão ou transferência entre setores.$md$,
   'intermediario'),

  ('via-aerea-dificil', 'Via Aérea Difícil', null,
   'Uma situação em que um anestesiologista tem dificuldade prevista ou inesperada para ventilar o paciente ou inserir um tubo na via aérea.',
   $md$Antecipar uma via aérea difícil (através de exame físico e histórico do paciente) permite preparar equipamento e um plano alternativo antes da indução anestésica — cenários inesperados são justamente os que mais aumentam o risco.$md$,
   'avancado'),

  ('erro-de-medicacao', 'Erro de Medicação', null,
   'Qualquer falha evitável no processo de prescrever, preparar, dispensar ou administrar um medicamento que pode (ou não) causar dano ao paciente.',
   $md$Nem todo erro de medicação causa dano — muitos são interceptados antes de chegar ao paciente (o que os classificaria também como um near miss). Ainda assim, são uma das causas mais comuns e mais evitáveis de eventos adversos em saúde.$md$,
   'basico')
) as v(slug, termo, expansao, definicao_curta, definicao_completa, nivel)
cross join (select id from categories where slug = 'saude-seguranca-paciente') as c
on conflict (slug) do nothing;

-- ---------------------------------------------------------------------------
-- Relações "veja também" envolvendo os termos novos
-- ---------------------------------------------------------------------------
insert into term_relations (term_id, related_term_id, tipo_relacao)
select t1.id, t2.id, v.tipo::term_relation_tipo
from (values
  -- Tecnologia
  ('container', 'deploy', 'relacionado'), ('deploy', 'container', 'relacionado'),
  ('container', 'ci-cd', 'relacionado'), ('ci-cd', 'container', 'relacionado'),
  ('middleware', 'backend', 'relacionado'), ('backend', 'middleware', 'relacionado'),
  ('orm', 'backend', 'relacionado'), ('backend', 'orm', 'relacionado'),
  ('cdn', 'deploy', 'relacionado'), ('deploy', 'cdn', 'relacionado'),
  ('oauth', 'jwt', 'relacionado'), ('jwt', 'oauth', 'relacionado'),
  ('websocket', 'backend', 'relacionado'), ('backend', 'websocket', 'relacionado'),
  ('serverless', 'deploy', 'relacionado'), ('deploy', 'serverless', 'relacionado'),

  -- Inteligência Artificial
  ('embedding', 'rag', 'pre_requisito'), ('rag', 'embedding', 'relacionado'),
  ('alucinacao', 'llm', 'relacionado'), ('llm', 'alucinacao', 'relacionado'),
  ('alucinacao', 'rag', 'veja_tambem'), ('rag', 'alucinacao', 'veja_tambem'),
  ('janela-de-contexto', 'token', 'relacionado'), ('token', 'janela-de-contexto', 'relacionado'),
  ('temperatura', 'llm', 'relacionado'), ('llm', 'temperatura', 'relacionado'),
  ('few-shot-learning', 'fine-tuning', 'veja_tambem'), ('fine-tuning', 'few-shot-learning', 'veja_tambem'),
  ('few-shot-learning', 'prompt-engineering', 'relacionado'), ('prompt-engineering', 'few-shot-learning', 'relacionado'),
  ('transformer', 'llm', 'pre_requisito'), ('llm', 'transformer', 'relacionado'),
  ('vies-algoritmico', 'llm', 'relacionado'), ('llm', 'vies-algoritmico', 'relacionado'),
  ('ia-multimodal', 'llm', 'relacionado'), ('llm', 'ia-multimodal', 'relacionado'),

  -- Negócios
  ('mrr', 'churn', 'relacionado'), ('churn', 'mrr', 'relacionado'),
  ('mrr', 'saas', 'relacionado'), ('saas', 'mrr', 'relacionado'),
  ('ltv', 'cac', 'relacionado'), ('cac', 'ltv', 'relacionado'),
  ('product-market-fit', 'mvp', 'relacionado'), ('mvp', 'product-market-fit', 'relacionado'),
  ('okr', 'kpi', 'relacionado'), ('kpi', 'okr', 'relacionado'),
  ('roadmap', 'mvp', 'relacionado'), ('mvp', 'roadmap', 'relacionado'),
  ('onboarding', 'churn', 'veja_tambem'), ('churn', 'onboarding', 'veja_tambem'),
  ('bootstrapping', 'saas', 'veja_tambem'), ('saas', 'bootstrapping', 'veja_tambem'),

  -- Saúde
  ('sedacao', 'asa', 'relacionado'), ('asa', 'sedacao', 'relacionado'),
  ('sedacao', 'pacu', 'relacionado'), ('pacu', 'sedacao', 'relacionado'),
  ('anestesia-regional', 'sedacao', 'relacionado'), ('sedacao', 'anestesia-regional', 'relacionado'),
  ('capnografia', 'via-aerea-dificil', 'relacionado'), ('via-aerea-dificil', 'capnografia', 'relacionado'),
  ('capnografia', 'iot-intubacao', 'relacionado'), ('iot-intubacao', 'capnografia', 'relacionado'),
  ('hipotermia-perioperatoria', 'pacu', 'relacionado'), ('pacu', 'hipotermia-perioperatoria', 'relacionado'),
  ('cultura-de-seguranca', 'near-miss', 'relacionado'), ('near-miss', 'cultura-de-seguranca', 'relacionado'),
  ('cultura-de-seguranca', 'evento-adverso', 'relacionado'), ('evento-adverso', 'cultura-de-seguranca', 'relacionado'),
  ('sbar', 'checklist-cirurgico', 'relacionado'), ('checklist-cirurgico', 'sbar', 'relacionado'),
  ('via-aerea-dificil', 'iot-intubacao', 'relacionado'), ('iot-intubacao', 'via-aerea-dificil', 'relacionado'),
  ('erro-de-medicacao', 'evento-adverso', 'relacionado'), ('evento-adverso', 'erro-de-medicacao', 'relacionado'),
  ('erro-de-medicacao', 'near-miss', 'veja_tambem'), ('near-miss', 'erro-de-medicacao', 'veja_tambem')
) as v(term_slug, related_slug, tipo)
join terms t1 on t1.slug = v.term_slug
join terms t2 on t2.slug = v.related_slug
on conflict do nothing;
