# Catálogo de skills (skillforge)

Duas fontes complementares — **não** duplicam o mesmo papel.

| Fonte | Onde | Quantidade | Papel |
| --- | --- | --- | --- |
| **GET** [sankhya-addon-sdk2](https://github.com/GRUPO-GET/sankhya-addon-sdk2) | `skills/sankhya-addon-sdk2` | 1 skill (`sankhya-addon-sdk`) + `references/` | Entrada única SDK Addon Studio **2.0.18+**: AutoDD, `@Controller`, ORM, repositório, doc oficial expandida (ex.: sub-abas nativas) |
| **DevCenter** [addon-studio](https://github.com/snk-devcenter/addon-studio) | `vendor/addon-studio/` (**incorporado**) | 25 skills + 6 agents | Skills granulares (XML, dbscript, Retrofit, JSP, jobs, …) |

Total instalado no addon: **26 skills** + **6 agents**.

## Quando usar qual

| Situação | Preferir |
| --- | --- |
| CRUD SDK novo, AutoDD, `@Controller` vs `@Service`, envelope JSON | `sankhya-addon-sdk` |
| Sub-aba filha em tela nativa (`parentInstance`, `TGFTOP`) | `sankhya-addon-sdk` → `references/native-child-tabs.md` |
| XML dicionário, tela cadastral, `datadictionary/` | `data-dictionary` (addon-studio) |
| Dbscript dual Oracle/MSSQL versionado | `database` + agent `dbscript-builder` |
| Trio entidade + XML + migration de uma vez | agent `entity-architect` |
| Retrofit, OkHttp, API externa | `retrofit` |
| `com.sankhya.util`, helpers nativos | `sankhya-utils` |
| HTML5 / AngularJS no Om | `sankhya-js` |
| JSP no addon | `jsp` |
| Action button, callback, business rule, job | skills homônimas |
| Setup `docs/ADDON.md` + `CLAUDE.md` | `init` (addon-studio) |

Sobreposição (`entity`, `controller`, `mapstruct`, …): addon-studio = fluxo Studio/plugin; GET = referências longas alinhadas à documentação developer.sankhya.com.br. Em dúvida no addon GET, abra **sankhya-addon-sdk** primeiro; use a skill granular para o artefato específico (XML, dbscript, front).

## Skills addon-studio (25)

`action-button`, `before-load-listener`, `build`, `business-rule`, `callback`, `controller-advice`, `controller`, `database`, `data-dictionary`, `dependency-injection`, `encoding`, `entity`, `init`, `job`, `jsp`, `listener`, `macros`, `mapstruct`, `repository`, `retrofit`, `sankhya-js`, `sankhya-utils`, `test`, `type-adapter`, `value`

Invocação Claude: `/entity`, `/database`, … (nome da pasta). Codex: `$entity`. Cursor: pasta em `.cursor/skills/entity/`.

## Agents addon-studio (6)

| Agent | Uso |
| --- | --- |
| `entity-architect` | Dicionário + dbscript + `@JapeEntity` juntos |
| `dbscript-builder` | Migrations dual DB |
| `controller-designer` | API REST / DTO / validação |
| `test-writer` | Testes do addon |
| `addon-reviewer` | Revisão de padrões |
| `troubleshooter` | Deploy, Guice, build |

Instalados em `.cursor/agents/`, `.claude/agents/`, `.codex/agents/` (Codex: `.toml`).

## Atualizar

```sh
git submodule update --remote skills/sankhya-addon-sdk2
# addon-studio: atualizar cópia em vendor/ — ver vendor/addon-studio/README.md
./install.sh /caminho/do/addon   # ou ~
```
