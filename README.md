# Skill: SDK Sankhya (Addon Studio 2.0)

Habilidade de agent para **Cursor**, **Claude Code** e **Codex** implementar add-ons no **SDK Sankhya novo** (JAPE + Guice + Bean Validation + MapStruct), com arquivo de entrada único e referências carregadas sob demanda.

Baseada na documentação oficial:

- [Introdução ao SDK](https://developer.sankhya.com.br/docs/introducao-sdk-sankhya)
- [Conceitos fundamentais](https://developer.sankhya.com.br/docs/conceitos-fundamentais)
- [Getting started](https://developer.sankhya.com.br/docs/iniciando)

Complementa (não substitui) o plugin [snk-devcenter/addon-studio](https://github.com/snk-devcenter/addon-studio) quando ele já estiver no projeto.

## O que a skill faz

- Exige `br.com.sankhya.studio:gradle-plugin` **≥ 2.0.18** no `build.gradle` antes de gerar código.
- Impõe o framework novo: `@JapeEntity`, `@Repository`, `@Controller`/`@Service`, `@Inject` (Guice), `@Transactional`, `@Valid`.
- Bloqueia legado (`DynamicVO`, `JapeSession.open`, `ServiceBean`) e JPA/Spring Data.
- Abre só o arquivo de referência do componente em uso (controller, ORM, macros, AutoDD, …).

## Estrutura

```text
sankhya-addon-sdk/
├── SKILL.md                          # entrada (sempre)
└── references/                       # sob demanda
    ├── version-build.md
    ├── controller.md
    ├── bean-validation.md
    ├── dependency-injection.md
    ├── transactional.md
    ├── orm.md
    ├── repository.md
    ├── mapstruct.md
    ├── type-adapters.md
    ├── logging.md
    ├── value.md
    ├── controller-advice.md
    ├── autodd.md
    ├── foreign-keys.md
    ├── macros.md
    └── before-load-listener.md
```

Cópias iguais em `.cursor/skills/`, `.claude/skills/` e `.codex/skills/` para os três agents descobrirem o pacote neste repositório.

## Instalação em um projeto de addon

Copie a pasta `sankhya-addon-sdk/` (ou clone este repositório como submodule) para o diretório de skills do agent:

| Agent | Destino no projeto do addon |
| --- | --- |
| Cursor | `.cursor/skills/sankhya-addon-sdk/` |
| Claude Code | `.claude/skills/sankhya-addon-sdk/` |
| Codex | `.codex/skills/sankhya-addon-sdk/` |

Você pode copiar para os três. No Cursor, se a skill aparecer duplicada, mantenha só `.cursor/skills/`.

Atalho:

```sh
./install.sh /caminho/do/seu-addon
```

## Como usar

Linguagem natural:

> Crie o controller, o repositório e a entidade JAPE desta tabela no padrão do SDK Sankhya 2.0.

Invocação explícita:

- Cursor / Claude: `/sankhya-addon-sdk`
- Codex: `$sankhya-addon-sdk`

## Premissas

- Java 8, WildFly/EJB, encoding ISO-8859-1 quando o Studio exigir.
- SQL portável Oracle + SQL Server via macros (`dbDate()`, `nullValue()`, …).
- Prefixo de tabelas e pacote-base vêm do projeto; se não houver padrão, o agent pergunta.
- AutoDD gera Table/NativeTable; menus, views e dashboards continuam no dicionário XML.

## Licença

MIT.
