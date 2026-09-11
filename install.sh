#!/usr/bin/env sh
set -eu

if [ "${1:-}" = "" ]; then
  echo "Uso: ./install.sh /caminho/do/projeto-addon"
  echo "Copia a skill do submódulo skills/sankhya-addon-sdk2 para os agents."
  exit 1
fi

TARGET=$1
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$ROOT/skills/sankhya-addon-sdk2"

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "Submódulo não inicializado em $SRC"
  echo "Rode: git submodule update --init --recursive"
  exit 1
fi

for dest in .cursor/skills .claude/skills .codex/skills; do
  mkdir -p "$TARGET/$dest"
  rm -rf "$TARGET/$dest/sankhya-addon-sdk"
  mkdir -p "$TARGET/$dest/sankhya-addon-sdk"
  cp -R "$SRC/SKILL.md" "$SRC/references" "$TARGET/$dest/sankhya-addon-sdk/"
  echo "Instalado em $TARGET/$dest/sankhya-addon-sdk"
done
