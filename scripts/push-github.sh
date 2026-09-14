#!/usr/bin/env sh
# Rode numa máquina com SSH no GitHub (git@github.com) e acesso ao org GRUPO-GET.
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SDK="$ROOT/skills/sankhya-addon-sdk2"
BUNDLE="$ROOT/vendor/sankhya-addon-sdk2.bundle"
SDK_REMOTE="git@github.com:GRUPO-GET/sankhya-addon-sdk2.git"
CATALOG_REMOTE="git@github.com:GRUPO-GET/skillforge.git"

if [ ! -f "$SDK/SKILL.md" ]; then
  if [ ! -f "$BUNDLE" ]; then
    echo "Nem o submódulo nem o bundle existem. Clone com --recurse-submodules ou copie vendor/sankhya-addon-sdk2.bundle."
    exit 1
  fi
  echo "→ Restaura skill a partir do bundle"
  rm -rf "$SDK"
  git clone "$BUNDLE" "$SDK"
fi

echo "→ Push sankhya-addon-sdk2"
git -C "$SDK" remote remove origin 2>/dev/null || true
git -C "$SDK" remote add origin "$SDK_REMOTE"
git -C "$SDK" push -u origin HEAD:main

echo "→ Push skillforge"
if git -C "$ROOT" remote get-url grupo-get >/dev/null 2>&1; then
  git -C "$ROOT" remote set-url grupo-get "$CATALOG_REMOTE"
else
  git -C "$ROOT" remote add grupo-get "$CATALOG_REMOTE"
fi
git -C "$ROOT" push -u grupo-get HEAD:main

echo "Pronto. Confira:"
echo "  https://github.com/GRUPO-GET/sankhya-addon-sdk2"
echo "  https://github.com/GRUPO-GET/skillforge"
