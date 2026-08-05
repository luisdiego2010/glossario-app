# Vault Zettelkasten

Vault do Obsidian para fichamento de livros e artigos, com o objetivo de gerar
material para o blog.

## Como abrir no Obsidian

1. Abra o Obsidian.
2. `File > Open folder as vault`.
3. Selecione esta pasta (`zettelkasten/`), não a raiz do repositório.
4. Os templates já ficam configurados automaticamente (plugin **Templates**
   aponta para a pasta `Templates/`). Para inserir um, use
   `Ctrl/Cmd + P` → `Templates: Insert template`.

## Fluxo de trabalho

```
Inbox  →  Literatura  →  Permanentes  →  Rascunhos de Blog
(ideia)   (fichamento)   (ideia atômica)   (post)
```

- **Inbox/** — notas fugazes (*fleeting*): capture qualquer ideia rápida
  aqui, sem se preocupar com forma. Processe e esvazie periodicamente.
- **Literatura/** — um fichamento por livro/artigo lido: resumo com suas
  próprias palavras, citações e reflexões. Uma nota de literatura pode gerar
  várias notas permanentes.
- **Permanentes/** — o núcleo do método: uma ideia atômica por nota, escrita
  de forma que faça sentido sozinha, ligada a outras notas permanentes por
  `[[wikilinks]]`. É daqui que os posts do blog nascem.
- **Rascunhos de Blog/** — quando algumas notas permanentes conectadas
  formam um argumento completo, monte o rascunho do post aqui, linkando as
  notas de origem.
- **Templates/** — modelos para os três tipos de nota (fleeting, literatura,
  permanente).

Toda nota nasce em **Inbox/**, qualquer que seja o tipo (o campo `type` no
frontmatter identifica qual modelo foi usado: `fleeting`, `literature` ou
`permanent`). Depois de processada, mova-a manualmente para `Literatura/` ou
`Permanentes/` — os templates de literatura e permanente trazem um lembrete
disso no topo da nota. Para achar rapidamente o que ainda está pendente de
mover, busque `path:Inbox` na busca do Obsidian.

### Criação rápida com QuickAdd (opcional)

Para que a nota já nasça em `Inbox/` com o modelo certo assim que você
escolher o tipo, instale o plugin de comunidade **QuickAdd**
(`Settings > Community plugins > Browse`) e crie uma choice do tipo
*Template* para cada modelo (`Fleeting`, `Literature`, `Permanent`), todas
apontando para a pasta `Inbox`. Agrupe as três numa choice do tipo *Multi* e
atribua um atalho em `Settings > Hotkeys`.

## Regra de ouro

Escreva as notas de literatura e permanentes sempre com suas próprias
palavras. Copiar e colar trechos sem processar quebra o propósito do método.
