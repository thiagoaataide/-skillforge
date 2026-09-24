#!/usr/bin/env sh
# Delega instalação para skills/sankhya-addon-sdk2 (router + Studio + agents).
set -eu

if [ "${1:-}" = "" ]; then
  echo "Uso: ./install.sh /caminho/do/projeto   # ou ./install.sh ~"
  echo ""
  echo "Instala via submódulo skills/sankhya-addon-sdk2:"
  echo "  - sankhya-addon-sdk (router GET + references/)"
  echo "  - 25 skills addon-studio + 6 agents"
  exit 1
fi

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SDK="$ROOT/skills/sankhya-addon-sdk2"

if [ ! -x "$SDK/install.sh" ]; then
  echo "Submódulo ausente ou install.sh não executável."
  echo "Rode: git submodule update --init --recursive"
  echo "      chmod +x skills/sankhya-addon-sdk2/install.sh"
  exit 1
fi

exec "$SDK/install.sh" "$1"
