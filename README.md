# agents

Skills partagees, chargees par Claude Code en local (symlinks depuis `~/.claude/skills/`) et dans les sessions cloud (routines) via la marketplace de plugin declaree ici.

## Cloud / routines

Les sessions cloud repartent d'un clone du repo projet : `~/.claude/` et `~/.agents/` ne voyagent pas. Pour donner les memes skills a une routine, declarer la marketplace dans le `.claude/settings.json` du repo :

```json
{
  "extraKnownMarketplaces": [
    { "name": "jd", "url": "https://github.com/JejeDurden2/agents" }
  ],
  "enabledPlugins": { "jd-skills@jd": true }
}
```

Les regles toujours actives (copy, engineering) ne passent pas par un plugin : les committer dans `.claude/rules/` du repo.

## Local

`~/.claude/skills/<nom>` est un symlink vers `~/.agents/skills/<nom>`.
