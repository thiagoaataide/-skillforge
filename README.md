# skillforge

Catálogo de **agent skills**. Cada skill vive no próprio repositório e entra aqui como *git submodule*.

| Skill | Repositório | Submódulo |
| --- | --- | --- |
| SDK Sankhya Addon Studio 2.0 | [sankhya-addon-sdk2](https://github.com/thiagoaataide/sankhya-addon-sdk2) | `skills/sankhya-addon-sdk2` |

## Clone

```sh
git clone --recurse-submodules git@github.com:thiagoaataide/-skillforge.git
cd -- -skillforge
```

Se o clone já foi feito sem submódulos:

```sh
git submodule update --init --recursive
```

## Instalar a skill Sankhya num addon

```sh
./install.sh /caminho/do/seu-addon
```

Copia `skills/sankhya-addon-sdk2` para `.cursor/skills/sankhya-addon-sdk`, `.claude/skills/` e `.codex/skills/` no projeto destino.

A skill sozinha (sem este catálogo):

```sh
git clone git@github.com:thiagoaataide/sankhya-addon-sdk2.git
cd sankhya-addon-sdk2
./install.sh /caminho/do/seu-addon
```

## Como usar no Cursor / Claude / Codex

Abra o **projeto do addon** (não precisa abrir o skillforge). No chat: `/sankhya-addon-sdk`.

## Atualizar o submódulo

```sh
git submodule update --remote skills/sankhya-addon-sdk2
git add skills/sankhya-addon-sdk2
git commit -m "chore: atualiza skill sankhya-addon-sdk2"
```

Edite a skill no repositório [sankhya-addon-sdk2](https://github.com/thiagoaataide/sankhya-addon-sdk2), não copie markdown para dentro do skillforge.

## Licença

MIT (cada skill pode ter a própria; a Sankhya está em MIT).
