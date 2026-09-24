# Catálogo de skills (skillforge)

Uma fonte no submódulo **[sankhya-addon-sdk2](https://github.com/GRUPO-GET/sankhya-addon-sdk2)** — router GET + DevCenter incorporado.

| Camada | Instalado como | Quantidade | Papel |
| --- | --- | --- | --- |
| **Router GET** | `sankhya-addon-sdk` | 1 skill + `references/` | SDK **2.0.18+**, AutoDD, `@Controller`, doc oficial, sub-abas nativas |
| **Studio** | nome da pasta (`entity`, `database`, …) | 25 skills | XML, dbscript, Retrofit, JSP, jobs, … |
| **Agents** | `.md` / `.toml` em `agents/` | 6 | Multi-artefato |

Total no addon: **26 skills** + **6 agents**. Sobreposição: **opção B (router)** — skills Studio apontam para `references/`; ver `skills/sankhya-addon-sdk2/ARCHITECTURE.md`.

## Quando usar qual

| Situação | Preferir |
| --- | --- |
| CRUD SDK novo, AutoDD, `@Controller` vs `@Service`, envelope JSON | `sankhya-addon-sdk` |
| Sub-aba filha em tela nativa (`parentInstance`, `TGFTOP`) | `sankhya-addon-sdk` → `references/native-child-tabs.md` |
| XML dicionário, tela cadastral, `datadictionary/` | `data-dictionary` |
| Dbscript dual Oracle/MSSQL versionado | `database` + agent `dbscript-builder` |
| Trio entidade + XML + migration de uma vez | agent `entity-architect` |
| Retrofit, OkHttp, API externa | `retrofit` |
| `com.sankhya.util`, helpers nativos | `sankhya-utils` |
| HTML5 / AngularJS no Om | `sankhya-js` |
| JSP no addon | `jsp` |
| Action button, callback, business rule, job | skills homônimas |
| Setup `docs/ADDON.md` + `CLAUDE.md` | `init` |

Sobreposição (`entity`, `controller`, …): leia a **reference GET** via `sankhya-addon-sdk` e a **skill Studio** granular; a Studio não contradiz a reference.

## Skills Studio (25)

`action-button`, `before-load-listener`, `build`, `business-rule`, `callback`, `controller-advice`, `controller`, `database`, `data-dictionary`, `dependency-injection`, `encoding`, `entity`, `init`, `job`, `jsp`, `listener`, `macros`, `mapstruct`, `repository`, `retrofit`, `sankhya-js`, `sankhya-utils`, `test`, `type-adapter`, `value`

Invocação Claude: `/entity`, `/database`, … Cursor/Codex: pasta em `.cursor/skills/entity/` ou `$entity`.

## Agents (6)

| Agent | Uso |
| --- | --- |
| `entity-architect` | Dicionário + dbscript + `@JapeEntity` juntos |
| `dbscript-builder` | Migrations dual DB |
| `controller-designer` | API REST / DTO / validação |
| `test-writer` | Testes do addon |
| `addon-reviewer` | Revisão de padrões |
| `troubleshooter` | Deploy, Guice, build |

## Atualizar

```sh
git submodule update --remote skills/sankhya-addon-sdk2
./install.sh /caminho/do/addon   # ou ~
```

Upstream DevCenter: `skills/sankhya-addon-sdk2/scripts/sync-addon-studio.sh` (commit no repo sdk2, depois gitlink aqui).
