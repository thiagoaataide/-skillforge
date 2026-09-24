# Addon Studio (cópia incorporada)

Conteúdo originado do repositório público **[snk-devcenter/addon-studio](https://github.com/snk-devcenter/addon-studio)** (plugin Sankhya Addon Studio 2.0).

| Campo | Valor |
| --- | --- |
| Versão upstream (tag) | ver `UPSTREAM_VERSION` |
| Commit upstream | ver `UPSTREAM_COMMIT` |
| Licença upstream | MIT — `LICENSE.upstream` |

Esta cópia fica **dentro do skillforge** para não depender do GitHub externo no dia a day. Para atualizar a partir do upstream:

```sh
git clone --depth=1 https://github.com/snk-devcenter/addon-studio.git /tmp/addon-studio
cp -R /tmp/addon-studio/plugins/addon-studio/skills/* vendor/addon-studio/skills/
cp -R /tmp/addon-studio/plugins/addon-studio/agents/* vendor/addon-studio/agents/
# Atualize UPSTREAM_* e commit.
```

Estrutura:

- `skills/` — 25 Agent Skills (`SKILL.md` + assets)
- `agents/` — 6 sub-agents (`.md` + `codex/*.toml`)

Instalação no addon: `./install.sh` na raiz do skillforge.
