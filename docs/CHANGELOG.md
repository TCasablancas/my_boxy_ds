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
- Documentação para agentes (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`), `docs/STATUS.md`, este changelog e CI (`.github/workflows/ci.yml`). Sem impacto no app.
