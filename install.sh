#!/usr/bin/env sh
set -eu

if [ "${1:-}" = "" ]; then
  echo "Uso: ./install.sh /caminho/do/projeto-addon"
  echo "Copia sankhya-addon-sdk para .cursor/skills, .claude/skills e .codex/skills."
  exit 1
fi

TARGET=$1
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC="$ROOT/sankhya-addon-sdk"

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "SKILL.md não encontrado em $SRC"
  exit 1
fi

for dest in .cursor/skills .claude/skills .codex/skills; do
  mkdir -p "$TARGET/$dest"
  rm -rf "$TARGET/$dest/sankhya-addon-sdk"
  cp -R "$SRC" "$TARGET/$dest/sankhya-addon-sdk"
  echo "Instalado em $TARGET/$dest/sankhya-addon-sdk"
done
