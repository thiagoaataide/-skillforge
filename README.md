# skillforge

Catálogo de **agent skills** para addons Sankhya e frentes relacionadas (Cursor, Claude Code, Codex).

| Pacote | Repositório | Caminho no catálogo |
| --- | --- | --- |
| SDK GET (entrada + doc expandida) | [GRUPO-GET/sankhya-addon-sdk2](https://github.com/GRUPO-GET/sankhya-addon-sdk2) | `skills/sankhya-addon-sdk2` |
| Addon Studio DevCenter (25 skills + 6 agents) | [snk-devcenter/addon-studio](https://github.com/snk-devcenter/addon-studio) | `external/addon-studio` |

**Total:** 26 skills + 6 agents após `./install.sh`. Detalhes e “quando usar qual”: [docs/SKILLS-CATALOG.md](docs/SKILLS-CATALOG.md).

## Clone

```sh
git clone --recurse-submodules git@github.com:GRUPO-GET/skillforge.git
cd skillforge
```

Sem submódulos no clone:

```sh
git submodule update --init --recursive
```

## Instalar no addon (ou global)

```sh
chmod +x install.sh
./install.sh /caminho/do/seu-addon
# global Cursor/Claude/Codex na sua máquina:
./install.sh ~
```

Copia para `.cursor/skills/`, `.claude/skills/`, `.codex/skills/`:

- `sankhya-addon-sdk` (GET)
- 25 pastas do [addon-studio](https://github.com/snk-devcenter/addon-studio) (`entity`, `database`, `retrofit`, `mapstruct`, …)

E agents para `.cursor/agents/`, `.claude/agents/`, `.codex/agents/` (Codex: `.toml`).

## Uso rápido

| Agent | Invocação |
| --- | --- |
| GET SDK | `/sankhya-addon-sdk` ou pedido em linguagem natural “padrão SDK 2.0” |
| Studio | `/entity`, `/database`, … ou Codex `$controller` |
| Especialista | “Use o entity-architect para …” |

## Atualizar

```sh
git pull
git submodule update --init --recursive
git submodule update --remote skills/sankhya-addon-sdk2
git submodule update --remote external/addon-studio
./install.sh /caminho/do/seu-addon
```

Edite a skill GET no repo **sankhya-addon-sdk2**. Skills DevCenter: upstream **addon-studio** (submódulo).

## Publicar (maintainers)

```sh
./scripts/push-github.sh
```

Remotes: `grupo-get` → GRUPO-GET/skillforge; espelho `thiago` → thiagoaataide/-skillforge (se configurado).

## Licença

MIT (catálogo). Respeite licenças dos submódulos (addon-studio MIT).
