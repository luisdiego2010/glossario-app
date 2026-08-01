-- Fontes de referência para os 32 termos adicionados em 0003
-- Encontradas e conferidas via busca (não fetch direto, ver conversa).
-- Nem toda fonte é Wikipédia: quando não havia verbete específico o
-- suficiente, foi usada documentação técnica ou entidade de referência.

update terms set fontes = '["https://en.wikipedia.org/wiki/Containerization_(computing)"]'::jsonb where slug = 'container';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Middleware_(programação)"]'::jsonb where slug = 'middleware';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Mapeamento_objeto-relacional"]'::jsonb where slug = 'orm';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Rede_de_fornecimento_de_conteúdo"]'::jsonb where slug = 'cdn';
update terms set fontes = '["https://pt.wikipedia.org/wiki/OAuth"]'::jsonb where slug = 'oauth';
update terms set fontes = '["https://en.wikipedia.org/wiki/JSON_Web_Token"]'::jsonb where slug = 'jwt';
update terms set fontes = '["https://en.wikipedia.org/wiki/WebSocket"]'::jsonb where slug = 'websocket';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Serverless"]'::jsonb where slug = 'serverless';

update terms set fontes = '["https://en.wikipedia.org/wiki/Embedding_(machine_learning)"]'::jsonb where slug = 'embedding';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Alucinação_(inteligência_artificial)"]'::jsonb where slug = 'alucinacao';
update terms set fontes = '["https://en.wikipedia.org/wiki/Context_window"]'::jsonb where slug = 'janela-de-contexto';
update terms set fontes = '["https://cloud.google.com/vertex-ai/generative-ai/docs/multimodal/content-generation-parameters"]'::jsonb where slug = 'temperatura';
update terms set fontes = '["https://en.wikipedia.org/wiki/Few-shot_learning"]'::jsonb where slug = 'few-shot-learning';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Transformer_(aprendizado_profundo)"]'::jsonb where slug = 'transformer';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Discriminação_algorítmica"]'::jsonb where slug = 'vies-algoritmico';
update terms set fontes = '["https://en.wikipedia.org/wiki/Multimodal_learning"]'::jsonb where slug = 'ia-multimodal';

update terms set fontes = '["https://corporatefinanceinstitute.com/resources/valuation/monthly-recurring-revenue-mrr/"]'::jsonb where slug = 'mrr';
update terms set fontes = '["https://en.wikipedia.org/wiki/Customer_lifetime_value"]'::jsonb where slug = 'ltv';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Custo_de_aquisição_de_clientes"]'::jsonb where slug = 'cac';
update terms set fontes = '["https://en.wikipedia.org/wiki/Product-market_fit"]'::jsonb where slug = 'product-market-fit';
update terms set fontes = '["https://en.wikipedia.org/wiki/Objectives_and_key_results"]'::jsonb where slug = 'okr';
update terms set fontes = '["https://en.wikipedia.org/wiki/Technology_roadmap"]'::jsonb where slug = 'roadmap';
update terms set fontes = '["https://en.wikipedia.org/wiki/User_onboarding"]'::jsonb where slug = 'onboarding';
update terms set fontes = '["https://en.wikipedia.org/wiki/Bootstrapping"]'::jsonb where slug = 'bootstrapping';

update terms set fontes = '["https://nysora.com/pt/informação-do-paciente/sedação/"]'::jsonb where slug = 'sedacao';
update terms set fontes = '["https://www.nysora.com/pt/geral/revisão-de-anestesia-regional-nysora/"]'::jsonb where slug = 'anestesia-regional';
update terms set fontes = '["https://en.wikipedia.org/wiki/Capnography"]'::jsonb where slug = 'capnografia';
update terms set fontes = '["https://www.nice.org.uk/guidance/cg65"]'::jsonb where slug = 'hipotermia-perioperatoria';
update terms set fontes = '["https://www.ahrq.gov/sops/about/patient-safety-culture.html"]'::jsonb where slug = 'cultura-de-seguranca';
update terms set fontes = '["https://www.ahrq.gov/teamstepps-program/curriculum/communication/tools/sbar.html"]'::jsonb where slug = 'sbar';
update terms set fontes = '["https://das.uk.com/guidelines/das_intubation_guidelines/"]'::jsonb where slug = 'via-aerea-dificil';
update terms set fontes = '["https://www.msdmanuals.com/pt/casa/medicamentos/considerações-gerais-sobre-medicamentos/erro-de-medicamentos"]'::jsonb where slug = 'erro-de-medicacao';
