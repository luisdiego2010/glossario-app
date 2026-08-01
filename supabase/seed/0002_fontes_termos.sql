-- Fontes de referência para os termos do seed inicial (0001)
-- Encontradas e conferidas via busca (não fetch direto, ver conversa) —
-- "framework" e "token" ficaram de fora por falta de fonte confiável.

update terms set fontes = '["https://pt.wikipedia.org/wiki/Interface_de_programação_de_aplicações"]'::jsonb where slug = 'api';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Kit_de_desenvolvimento_de_software"]'::jsonb where slug = 'sdk';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Front-end_e_back-end"]'::jsonb where slug = 'frontend';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Front-end_e_back-end"]'::jsonb where slug = 'backend';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Repositório_(controle_de_versão)"]'::jsonb where slug = 'repositorio';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Implantação_de_software"]'::jsonb where slug = 'deploy';
update terms set fontes = '["https://en.wikipedia.org/wiki/Webhook"]'::jsonb where slug = 'webhook';
update terms set fontes = '["https://en.wikipedia.org/wiki/CI/CD"]'::jsonb where slug = 'ci-cd';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Modelos_de_linguagem_de_grande_escala"]'::jsonb where slug = 'llm';
update terms set fontes = '["https://en.wikipedia.org/wiki/Model_Context_Protocol"]'::jsonb where slug = 'mcp';
update terms set fontes = '["https://en.wikipedia.org/wiki/Retrieval-augmented_generation"]'::jsonb where slug = 'rag';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Engenharia_de_prompts"]'::jsonb where slug = 'prompt-engineering';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Fine-tuning_(aprendizado_profundo)"]'::jsonb where slug = 'fine-tuning';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Agente_de_IA"]'::jsonb where slug = 'agente-de-ia';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Software_como_serviço"]'::jsonb where slug = 'saas';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Gestão_de_relacionamento_com_o_cliente"]'::jsonb where slug = 'crm';
update terms set fontes = '["https://en.wikipedia.org/wiki/Business-to-business"]'::jsonb where slug = 'b2b';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Business-to-consumer"]'::jsonb where slug = 'b2c';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Produto_viável_mínimo"]'::jsonb where slug = 'mvp';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Indicador-chave_de_desempenho"]'::jsonb where slug = 'kpi';
update terms set fontes = '["https://en.wikipedia.org/wiki/Churn_rate"]'::jsonb where slug = 'churn';
update terms set fontes = '["https://en.wikipedia.org/wiki/Business_as_usual_(business)"]'::jsonb where slug = 'bau';
update terms set fontes = '["https://en.wikipedia.org/wiki/ASA_physical_status_classification_system"]'::jsonb where slug = 'asa';
update terms set fontes = '["https://en.wikipedia.org/wiki/Post-anesthesia_care_unit"]'::jsonb where slug = 'pacu';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Reanimação_cardiorrespiratória"]'::jsonb where slug = 'rcp';
update terms set fontes = '["https://pt.wikipedia.org/wiki/Intubação_endotraqueal"]'::jsonb where slug = 'iot-intubacao';
update terms set fontes = '["https://en.wikipedia.org/wiki/Near_miss_(safety)"]'::jsonb where slug = 'near-miss';
update terms set fontes = '["https://en.wikipedia.org/wiki/WHO_Surgical_Safety_Checklist"]'::jsonb where slug = 'checklist-cirurgico';
update terms set fontes = '["https://www.who.int/publications/i/item/the-conceptual-framework-for-the-international-classification-for-patient-safety-(icps)"]'::jsonb where slug = 'evento-adverso';
