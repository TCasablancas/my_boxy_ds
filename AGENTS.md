# AGENTS.md — my_boxy_ds

Fonte única de regras para agentes de IA neste repo. `CLAUDE.md`, `GEMINI.md` e `.github/copilot-instructions.md` apontam para cá.

## Papel do repo
- Design system do MyBoxy (marketplace de produtos artesanais e manufaturados).
- Pacote Flutter puro de UI: design tokens (cores, tipografia, espaçamento, raio, sombra, borda) e componentes visuais.
- Consumido pelo app `my_boxy_flutter` via `path: ../my_boxy_ds` no `pubspec.yaml` do app.
- O app importa arquivos por caminho (`package:my_boxy_ds/components/containers/mb_main_view.dart`). Logo, **todo arquivo e classe pública em `lib/` é API pública**: renomear, mover ou mudar assinatura quebra o app.

## Estrutura
```
lib/
  my_boxy_ds.dart              # barrel principal (exporta tokens + parte das categorias)
  components/<categoria>/      # buttons, cards, caroussels, containers, input, labels, menus, selectors, tiles, ...
    <categoria>.dart           # barrel da categoria (quando existe)
    mb_<nome>.dart             # um componente por arquivo
  ui/design_tokens/            # TOKENS ATUAIS: app_colors, app_text_styles, app_sizes, app_radius, ...
  ui/formatters/               # formatadores de exibição (ex.: moeda BRL)
  ui/icons/                    # ícones
  ui/mb_design_tokens.dart, mb_typography.dart, mb_box_decorations.dart, mb_input_decorations.dart  # LEGADO
assets/                        # fontes (Lexend, SFMono, Gloock), imagens, animações Lottie
test/                          # espelha lib/ (test/components/<categoria>/mb_<nome>_test.dart)
example/                       # app demo que usa o pacote
docs/STATUS.md                 # inventário de tokens e componentes
docs/CHANGELOG.md              # mudanças que afetam o app
```

## Tokens
- Use apenas `lib/ui/design_tokens/`: `AppColors`, `AppTextStyles`, `AppFonts`, `AppSizes`, `AppRadius`, `AppBorders`, `AppShadows`, `AppDecorations`.
- Import: `import '../../ui/design_tokens/design_tokens.dart';` (relativo dentro do pacote).
- Não use o legado (`AppTypography`, `AppSpacing`, `AppBoxDecorations`, `AppInputDecorations`, `AppColors` de `mb_design_tokens.dart`) em código novo. Não apague o legado sem registrar no CHANGELOG.
- Faltou um token? Adicione-o no arquivo `app_*.dart` correto, com nome semântico, e registre em `docs/STATUS.md` e `docs/CHANGELOG.md`.

## Como criar um componente novo
1. Escolha a categoria em `lib/components/<categoria>/` (crie a pasta só se nenhuma servir).
2. Crie `mb_<nome>.dart` com a classe `MB<Nome>`; um componente público por arquivo.
3. Construtor `const`, todos os campos `final`, parâmetros nomeados; `required` só no essencial e defaults vindos de tokens.
4. Dados entram por parâmetros e saem por callbacks (`VoidCallback`, `ValueChanged<T>`). Sem estado de negócio.
5. Estilo só com tokens. Permita override opcional (ex.: `Color? backgroundColor`) com fallback para o token.
6. Exporte no barrel da categoria (`<categoria>.dart`); se a categoria for nova, exporte o barrel em `lib/my_boxy_ds.dart`.
7. Crie `test/components/<categoria>/mb_<nome>_test.dart` (widget test: renderiza, callbacks disparam, estados principais).
8. Opcional: adicione uma tela em `example/lib/views/`.
9. Atualize `docs/STATUS.md` e, se o app for afetado, `docs/CHANGELOG.md`.
10. Rode `flutter analyze` e `flutter test` antes de concluir.

## Convenção de nomes
- Arquivos: `snake_case`, prefixo `mb_` (`mb_main_btn.dart`, `mb_coupon_card.dart`).
- Classes de componente: prefixo `MB` + PascalCase (`MBMainButton`, `MBCouponCard`).
- Sufixos por tipo: `_btn`, `_card`, `_tile`, `_label`, `_container`, `_selector`, `_input`, `_menu`, `_header`, `_view`, `_shimmer`.
- Tokens: classes `App*` (`abstract final class`), membros `lowerCamelCase` semânticos (`textPrimary`, não `grey900Text`).
- Barrels: nome da pasta (`buttons/buttons.dart`).
- Testes: `<arquivo>_test.dart` no mesmo caminho relativo dentro de `test/`.

## Mudanças na API pública
- Quebra = remover/renomear arquivo, classe, parâmetro ou token; mudar tipo ou default de parâmetro; tornar opcional em `required`.
- Prefira mudanças aditivas (novo parâmetro opcional, novo token). Para substituir algo, marque o antigo com `@Deprecated('Use X')` e mantenha-o.
- Toda quebra vai em `docs/CHANGELOG.md` na seção **Quebra**, com instrução de migração para o app.

## Comandos
```
flutter pub get
flutter analyze
flutter test
cd example && flutter run
```

## NÃO FAZER
- Colocar lógica de negócio ou chamada de API (HTTP, Firebase, repositórios, regras de preço/estoque/pedido) neste repo. Componentes só recebem dados e emitem eventos.
- Usar cor, fonte, tamanho de fonte, espaçamento ou raio fixo no componente (`Color(0xFF...)`, `Colors.*`, `fontSize: 14`, `EdgeInsets.all(12)`) em vez de token.
- Quebrar a API pública de um componente (inclusive mover/renomear arquivo) sem registrar em `docs/CHANGELOG.md`.
- Tocar em outros repos (`my_boxy_flutter` ou qualquer outro). Se o app precisar mudar, descreva a migração no CHANGELOG.
- Fazer commit ou push sem pedido explícito.
