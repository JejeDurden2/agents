#!/usr/bin/env bash
# Copie les skills partagees dans le .claude/skills/ des repos passes en argument.
#
# Pourquoi copier plutot que symlink ou plugin : une session cloud (routine) repart
# d'un clone du repo. Ni ~/.claude/, ni ~/.agents/, ni les marketplaces declarees dans
# le .claude/settings.json du repo n'y arrivent. Seul .claude/skills/ committe est charge.
#
# ponytail: copie plate, une skill par dossier. rsync --delete est cadre a l'interieur
# d'une seule skill, jamais sur .claude/skills/ entier (les repos y ont leurs propres skills).
#
# Usage : ~/.agents/sync-skills.sh ~/Personnal-website ~/livia ...
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"

for repo in "$@"; do
  dst="$repo/.claude/skills"
  mkdir -p "$dst"
  for dir in "$src"/*/; do
    name="$(basename "$dir")"
    mkdir -p "$dst/$name"
    rsync -a --delete "$dir" "$dst/$name/"
  done
  echo "$repo : $(find "$src" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ') skills synchronisees"
done
