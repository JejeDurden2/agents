#!/bin/bash
# Setup script de l'environnement cloud env_012LyvByjoJRSGGE6P53vjQS.
# A coller dans claude.ai/code > l'environnement > champ "Setup script".
#
# Deux choses que l'image de base ne fournit pas :
# 1. les skills partagees, sans les dupliquer dans aucun repo
# 2. le binaire gh, absent de l'image alors que les routines s'en servent
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

# --- gh -----------------------------------------------------------------
# GH_TOKEN est injecte par le proxy GitHub, mais le binaire manque : les
# routines Sentry et SEO en ont besoin pour les issues et les PR.
if ! command -v gh > /dev/null 2>&1; then
  apt-get update -qq && apt-get install -y -qq gh || true
fi
command -v gh > /dev/null 2>&1 && gh --version | head -1 || echo "gh: indisponible"

exit 0
