# skillforge

Catálogo de **agent skills** para addons Sankhya (Cursor, Claude Code, Codex).

| Pacote | Origem | No skillforge |
| --- | --- | --- |
| SDK GET | [GRUPO-GET/sankhya-addon-sdk2](https://github.com/GRUPO-GET/sankhya-addon-sdk2) | **Submódulo** `skills/sankhya-addon-sdk2` |
| Addon Studio DevCenter | [snk-devcenter/addon-studio](https://github.com/snk-devcenter/addon-studio) | **Cópia incorporada** em `vendor/addon-studio/` (25 skills + 6 agents) |

A cópia do addon-studio traz atribuição em [vendor/addon-studio/README.md](vendor/addon-studio/README.md) e não depende do repo público estar online. **Total instalado:** 26 skills + 6 agents. Catálogo: [docs/SKILLS-CATALOG.md](docs/SKILLS-CATALOG.md).

## Clone

```sh
git clone --recurse-submodules git@github.com:GRUPO-GET/skillforge.git
cd skillforge
git submodule update --init skills/sankhya-addon-sdk2
```

## Instalar

```sh
chmod +x install.sh
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

Para refrescar a cópia DevCenter a partir do GitHub público, siga [vendor/addon-studio/README.md](vendor/addon-studio/README.md).

## Licença

MIT (catálogo). Addon Studio incorporado: MIT — ver `vendor/addon-studio/LICENSE.upstream`.
