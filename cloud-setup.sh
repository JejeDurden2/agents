#!/bin/bash
# Setup script de l'environnement cloud env_012LyvByjoJRSGGE6P53vjQS.
# A coller dans claude.ai/code > l'environnement > champ "Setup script".
#
# Une seule chose : les skills partagees, sans les dupliquer dans aucun repo.
#
# Pas d'install de gh ici. Le binaire s'installe, mais le proxy GitHub refuse
# tout appel CLI (403), y compris en lecture : il ne sert qu'un jeu d'operations
# fixe aux outils mcp__github__*. Les routines passent par ces outils.
#
# Tourne en root, apres le clone, avant Claude Code. Le resultat est mis en
# cache : le script ne rejoue qu'a l'invalidation du cache. Pour forcer un
# refresh des skills, modifier ce script (toute edition invalide le cache).
#
# ponytail: pas de gestion de version, le cache fait foi.
set -u

# --- skills partagees ---------------------------------------------------
DEST=/opt/jd-agents
rm -rf "$DEST"
if git clone --depth 1 https://github.com/JejeDurden2/agents.git "$DEST"; then
  mkdir -p /root/.claude/skills
  for dir in "$DEST"/skills/*/; do
    ln -sfn "$dir" "/root/.claude/skills/$(basename "$dir")"
  done
  echo "jd-agents: $(ls /root/.claude/skills | wc -l) skills liees"
else
  echo "jd-agents: clone echoue, on continue sans les skills"
fi

exit 0
