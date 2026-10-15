# Copilot — my_boxy_ds

Versão condensada. Regras completas em `AGENTS.md` (fonte única).

- Repo: design system do MyBoxy. Pacote Flutter só de UI (tokens + componentes), consumido pelo app `my_boxy_flutter` via `path`.
- O app importa arquivos por caminho: todo arquivo e classe pública em `lib/` é API pública.
- Componentes: `lib/components/<categoria>/mb_<nome>.dart`, classe `MB<Nome>`, um componente por arquivo.
- Construtor `const`, campos `final`, parâmetros nomeados; dados por parâmetro, eventos por callback.
- Estilo só com tokens de `lib/ui/design_tokens/`: `AppColors`, `AppTextStyles`, `AppFonts`, `AppSizes`, `AppRadius`, `AppBorders`, `AppShadows`, `AppDecorations`.
- Não usar legado em código novo: `AppTypography`, `AppSpacing`, `AppBoxDecorations`, `AppInputDecorations`, `mb_design_tokens.dart`.
- Exportar no barrel da categoria (`<categoria>.dart`).
- Teste em `test/components/<categoria>/mb_<nome>_test.dart`.
- Atualizar `docs/STATUS.md`; mudança que afeta o app vai em `docs/CHANGELOG.md`.
- Validar com `flutter analyze` e `flutter test`.

## NÃO FAZER
- Lógica de negócio ou chamada de API neste repo.
- Cor, fonte ou espaçamento fixo (`Color(0xFF...)`, `Colors.*`, `fontSize: 14`, `EdgeInsets.all(12)`) em vez de token.
- Quebrar API pública (renomear/mover arquivo, classe, parâmetro, token) sem registrar no CHANGELOG com migração.
- Tocar em outros repos.
