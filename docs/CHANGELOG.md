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
- `MBCommentProductStackCard` (`cards/mb_comment_product_stack_card.dart`): card de comentário tocável, com camadas visuais estáticas para simular stack e sem ações internas.
- `MBRatingDistributionCard` (`cards/mb_rating_distribution_card.dart`): barras de avaliações por nota (5 a 1), com seleção para filtro (`selectedRatings`, `onRatingTap`).
- `MBCommentProductCard`: parâmetros opcionais `userAlias`, `rating`, `likesCount`, `photosCount`, `width` (padrão 300; `null` ocupa a largura), `maxLines` (padrão 2; `null` mostra tudo), `onLikeTap`, `onPhotosTap`.

### Alterado
- `MBCommentProductCard`: os números fixos (1234, 12, 543) viraram `rating`, `photosCount` e `likesCount` (0 quando não informados).
- `MBUserHeaderContainer`: `imageUrl` http(s) carrega da rede; vazio mostra o avatar sem foto (antes sempre lia arquivo local).

### Adicionado
- `MBShrinkContentView`: conteúdo expansível com altura inicial de 80 px, animação, botão "Ver mais"/"Ver menos" e gradiente inferior.
- `MBMainBottomsheet.show`: `entrypoint` e `asyncBuilder` opcionais, informados juntos, para apresentar conteúdo conforme o estado de uma chamada síncrona ou assíncrona. O builder decide como exibir carregamento, dados e erros; a sheet pode ser fechada durante a chamada.
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
