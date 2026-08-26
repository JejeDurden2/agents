#!/bin/bash
# Setup script de l'environnement cloud env_012LyvByjoJRSGGE6P53vjQS.
# A coller dans claude.ai/code > l'environnement > champ "Setup script".
#
# Donne les skills partagees a TOUTES les routines et a tous les repos, sans les
# dupliquer dans aucun repo. Tourne en root, apres le clone, avant Claude Code.
# Le resultat est mis en cache : le script ne rejoue qu'a l'invalidation du cache.
#
# ponytail: pas de gestion de version, le cache fait foi. Pour forcer un refresh,
# modifier ce script (toute edition invalide le cache).
set -u

DEST=/opt/jd-agents
rm -rf "$DEST"
git clone --depth 1 https://github.com/JejeDurden2/agents.git "$DEST" || exit 0

mkdir -p /root/.claude/skills
for dir in "$DEST"/skills/*/; do
  ln -sfn "$dir" "/root/.claude/skills/$(basename "$dir")"
done

echo "jd-agents: $(ls /root/.claude/skills | wc -l) skills liees"
exit 0
