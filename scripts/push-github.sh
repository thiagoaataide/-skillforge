#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SDK="$ROOT/skills/sankhya-addon-sdk2"
BUNDLE="$ROOT/vendor/sankhya-addon-sdk2.bundle"
SDK_REMOTE="git@github.com:GRUPO-GET/sankhya-addon-sdk2.git"
CATALOG_REMOTE="git@github.com:GRUPO-GET/skillforge.git"
CATALOG_THIAGO="git@github.com:thiagoaataide/-skillforge.git"

if [ ! -f "$SDK/SKILL.md" ]; then
  if [ -f "$BUNDLE" ]; then
    rm -rf "$SDK"
    git clone "$BUNDLE" "$SDK"
  else
    echo "Falta skills/sankhya-addon-sdk2"
    exit 1
  fi
fi

if [ ! -d "$ROOT/vendor/addon-studio/skills/entity" ]; then
  echo "Falta vendor/addon-studio (cópia incorporada)"
  exit 1
fi

echo "→ Push sankhya-addon-sdk2"
git -C "$SDK" remote set-url origin "$SDK_REMOTE"
git -C "$SDK" push -u origin HEAD:main

echo "→ Push skillforge (grupo-get)"
if git -C "$ROOT" remote get-url grupo-get >/dev/null 2>&1; then
  git -C "$ROOT" remote set-url grupo-get "$CATALOG_REMOTE"
else
  git -C "$ROOT" remote add grupo-get "$CATALOG_REMOTE"
fi
git -C "$ROOT" push -u grupo-get HEAD:main

if git -C "$ROOT" remote get-url thiago >/dev/null 2>&1; then
  echo "→ Push skillforge (thiago)"
  git -C "$ROOT" remote set-url thiago "$CATALOG_THIAGO"
  git -C "$ROOT" push -u thiago HEAD:main
fi

echo "Pronto. addon-studio vai no commit do skillforge (vendor/)."
