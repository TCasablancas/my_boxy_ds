# Changelog — impacto no app

Registro de mudanças deste design system que afetam o app `my_boxy_flutter`.
Entrada mais recente no topo. Use as seções abaixo; omita as vazias.

- **Adicionado**: novos componentes, tokens ou parâmetros opcionais (não exige mudança no app).
- **Alterado**: mudança visual ou de comportamento sem quebra de assinatura.
- **Depreciado**: itens marcados com `@Deprecated`, com o substituto.
- **Quebra**: remoção/renomeação de arquivo, classe, parâmetro ou token; mudança de tipo/default. Sempre com **Migração** para o app.

Modelo:

```
## AAAA-MM-DD — título curto
### Quebra
- `MBExemplo`: parâmetro `color` renomeado para `backgroundColor`.
  - Migração: no app, trocar `MBExemplo(color: x)` por `MBExemplo(backgroundColor: x)`.
```

## Não lançado

### Adicionado
- `MBHomeHeader`: parâmetros opcionais `greeting` (padrão `'Olá, '`), `location`, `locationAction`, `onLocationTap` e `isLoading` (skeleton). Nome e alias truncam com reticências.
- `MBHomeCarouselItem.altText` (leitor de tela) e `MBHomeCarouselListHeader.imageBuilder` (o app injeta a imagem, ex.: com cache).
- `MBUserHomeCarouselCard.image` opcional e placeholder enquanto a imagem padrão carrega.

### Alterado
- `MBHomeHeader`: `userAlias` passou a ser opcional (sem alias, a linha de baixo mostra só o local). A cidade fixa "Santos - SP" saiu: o local só aparece quando `location` é informado. Estilos migrados para os tokens atuais, com o mesmo visual. Virou `StatelessWidget`.
  - Migração: no app, passar `location: 'Cidade - UF'` para continuar mostrando a cidade.
- `MBHomeCarouselListHeader`: trocar `items` (ids diferentes) recria o carrossel; antes a lista nova era ignorada.
- `MBCarouselShimmer`: agora imita o carrossel (card central com os vizinhos aparecendo).

### Adicionado
- Documentação para agentes (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`), `docs/STATUS.md`, este changelog e CI (`.github/workflows/ci.yml`). Sem impacto no app.
