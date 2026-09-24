#!/usr/bin/env sh
# Instala skills e agents do skillforge no projeto (addon) ou global (~).
set -eu

if [ "${1:-}" = "" ]; then
  echo "Uso: ./install.sh /caminho/do/projeto   # ou ./install.sh ~"
  echo ""
  echo "Instala:"
  echo "  - sankhya-addon-sdk (submódulo skills/sankhya-addon-sdk2)"
  echo "  - 25 skills addon-studio (vendor/addon-studio/skills — cópia incorporada)"
  echo "  - 6 agents addon-studio (vendor/addon-studio/agents)"
  exit 1
fi

TARGET=$1
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SDK_SRC="$ROOT/skills/sankhya-addon-sdk2"
STUDIO_SKILLS="$ROOT/vendor/addon-studio/skills"
STUDIO_AGENTS="$ROOT/vendor/addon-studio/agents"
STUDIO_CODEX_AGENTS="$STUDIO_AGENTS/codex"

if [ ! -f "$SDK_SRC/SKILL.md" ]; then
  echo "Submódulo skills/sankhya-addon-sdk2 ausente."
  echo "Rode: git submodule update --init --recursive"
  exit 1
fi

if [ ! -d "$STUDIO_SKILLS/entity" ]; then
  echo "Cópia vendor/addon-studio/skills ausente."
  exit 1
fi

install_skill_dir() {
  src_dir=$1
  skill_name=$2
  for agent_root in .cursor/skills .claude/skills .codex/skills; do
    dest="$TARGET/$agent_root/$skill_name"
    mkdir -p "$dest"
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -R "$src_dir"/. "$dest/"
    echo "  skill → $dest"
  done
}

echo "→ sankhya-addon-sdk (GET / SDK 2.0 + references/)"
install_skill_dir "$SDK_SRC" "sankhya-addon-sdk"

echo "→ addon-studio (25 skills — origem snk-devcenter/addon-studio)"
for skill_path in "$STUDIO_SKILLS"/*/; do
  [ -f "${skill_path}SKILL.md" ] || continue
  skill_name=$(basename "$skill_path")
  install_skill_dir "$skill_path" "$skill_name"
done

echo "→ agents addon-studio (6 especialistas)"
for agent_root in .cursor/agents .claude/agents; do
  dest_dir="$TARGET/$agent_root"
  mkdir -p "$dest_dir"
  for agent_md in "$STUDIO_AGENTS"/*.md; do
    [ -f "$agent_md" ] || continue
    cp "$agent_md" "$dest_dir/"
    echo "  agent → $dest_dir/$(basename "$agent_md")"
  done
done

if [ -d "$STUDIO_CODEX_AGENTS" ]; then
  codex_dest="$TARGET/.codex/agents"
  mkdir -p "$codex_dest"
  for agent_toml in "$STUDIO_CODEX_AGENTS"/*.toml; do
    [ -f "$agent_toml" ] || continue
    cp "$agent_toml" "$codex_dest/"
    echo "  codex agent → $codex_dest/$(basename "$agent_toml")"
  done
fi

echo ""
echo "Pronto em: $TARGET"
echo "Skills GET: /sankhya-addon-sdk ou linguagem natural SDK 2.0."
echo "Skills Studio: /entity, /controller, … ou \$entity no Codex (nome da pasta)."
