#!/usr/bin/env sh
# Rode numa máquina com SSH no GitHub (git@github.com).
# Publica a skill em sankhya-addon-sdk2 e o catálogo em -skillforge.
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SDK="$ROOT/skills/sankhya-addon-sdk2"

if [ ! -d "$SDK/.git" ] && [ ! -f "$SDK/.git" ]; then
  echo "Submódulo ausente em $SDK"
  exit 1
fi

echo "→ Push sankhya-addon-sdk2"
git -C "$SDK" remote set-url origin git@github.com:thiagoaataide/sankhya-addon-sdk2.git
git -C "$SDK" push -u origin HEAD:main

echo "→ Push skillforge"
if git -C "$ROOT" remote get-url github >/dev/null 2>&1; then
  git -C "$ROOT" remote set-url github git@github.com:thiagoaataide/-skillforge.git
else
  git -C "$ROOT" remote add github git@github.com:thiagoaataide/-skillforge.git
fi
git -C "$ROOT" push -u github HEAD:main

echo "Pronto."
