# skillforge

Catálogo de **agent skills** para addons Sankhya (Cursor, Claude Code, Codex).

| Pacote | Origem | No skillforge |
| --- | --- | --- |
| SDK GET + DevCenter | [GRUPO-GET/sankhya-addon-sdk2](https://github.com/GRUPO-GET/sankhya-addon-sdk2) | **Submódulo** `skills/sankhya-addon-sdk2` (router + 25 skills Studio + 6 agents) |

**Total instalado:** 26 skills + 6 agents. Catálogo de uso: [docs/SKILLS-CATALOG.md](docs/SKILLS-CATALOG.md). Arquitetura router (opção B): submódulo → [ARCHITECTURE.md](skills/sankhya-addon-sdk2/ARCHITECTURE.md).

## Clone

```sh
git clone --recurse-submodules git@github.com:GRUPO-GET/skillforge.git
cd skillforge
git submodule update --init skills/sankhya-addon-sdk2
```

## Instalar

```sh
chmod +x install.sh skills/sankhya-addon-sdk2/install.sh
./install.sh /caminho/do/seu-addon
# ou global:
./install.sh ~
```

## Atualizar

```sh
git pull
git submodule update --init --recursive
git submodule update --remote skills/sankhya-addon-sdk2
./install.sh /caminho/do/seu-addon
```

Para refrescar addon-studio upstream, rode `./skills/sankhya-addon-sdk2/scripts/sync-addon-studio.sh` **dentro do submódulo**, commit no repo sdk2 e atualize o gitlink no skillforge.

## Licença

MIT (catálogo). Conteúdo DevCenter: MIT — ver `skills/sankhya-addon-sdk2/third-party/addon-studio/`.
