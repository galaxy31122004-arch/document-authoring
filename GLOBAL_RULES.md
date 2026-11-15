# Global rules (single source)

This file is the ONE source of global rules for every AI host on this machine (Claude, Codex, Copilot...). Host files only point here: `~/.claude/CLAUDE.md` imports it, `~/.codex/AGENTS.md` and `~/.copilot/copilot-instructions.md` link or point to it. Edit only this file. Personal skills live in `D:\Personal-Skills\<skill>\` and every host's skill folder holds junctions to them; never keep a separate copy of a skill or rule elsewhere. Exception: `~/.claude/skills/synced\` (Anthropic built-in skills that Claude Code syncs itself) and `~/.codex/skills/.system\` belong to the host; leave them as they are, do not move or delete them.

## Storage location (drive D: by default)
- Save all downloaded data (datasets, model weights, archives, installers, videos, extracted files, outputs) **inside the current project folder on D:** (e.g. `<project>/raw`, `<project>/data`, `<project>/weights`, or the `structured-workspace` folders `documents/sources/`, `sandbox/`). With no project, use `D:\Downloads\<topic>\`. Never on drive C:.
- If a download lands on C: (e.g. `C:\Users\...\Downloads` from a browser), move it to D: right after it finishes and say so.
- Point tool caches at D: when running tools: `PIP_CACHE_DIR=D:\Caches\pip`, `npm_config_cache=D:\Caches\npm`, `HF_HOME=D:\Caches\huggingface`, `TORCH_HOME=D:\Caches\torch`, `PLATFORMIO_CORE_DIR=D:\.platformio`. Do not change persistent environment variables without asking.
- Keep on C: only what must live there: system installs, AI host config, the session scratchpad.
- Temporary files/caches that must be on C: go in one place only per host: `%LOCALAPPDATA%\Temp\<host>\` (Claude: the session scratchpad under `%LOCALAPPDATA%\Temp\claude\`; Codex: `%LOCALAPPDATA%\Temp\codex\`; Copilot: `%LOCALAPPDATA%\Temp\copilot\`). Never scatter them in the user profile, Desktop, `C:\` root or project folders on C:. These folders can be deleted when no session is running.

## Old versions after an update
- After updating a tool/app/package/VM bundle (or on noticing several installed versions), delete old installed versions not used in the last 7 days. Keep the active version (`current` junction/symlink target, the active install) and anything modified in the last 7 days (modified time = "last used").
- Scope is only install/package/cache folders (`~/.codex/packages`, `~/.vscode/extensions`, `~/.platformio/packages`, `%LOCALAPPDATA%\Programs`, app VM bundles...).
- **Never delete project files**: nothing inside a workspace/project, including `versions/`, `firmware/vX.Y.Z/`, `releases/`, build outputs, Git tags, backups. Never user data, configs or sessions. Unsure → ask first.
- Report what was deleted and the space freed.

## Workspaces and deliverables
- Every workspace and every personal-skill output follows the `structured-workspace` skill (`D:\Personal-Skills\structured-workspace\SKILL.md`): folders `sandbox/`, `documents/`, `source-code/`, `versions/`, `considerations/`, and mandatory `vX.Y.Z` versioning. When a skill and this base disagree, the base wins.
- **Exception: TMT projects** (`D:\TMT\...`): do not apply or propose personal skills (structured-workspace, document-authoring, presentation-from-reference, tao-slide, web-ui-style...) there. Use only the repo's local skills and the AXON (TMT) skills, and follow that repo's own AGENTS.md conventions.

## Work log (every task)
- After every task that changes something (files, builds, flashing, installs, config), append an entry to the project's work log: `documents/work-log.md` (TMT projects: the repo's own log convention if any, else `docs/work-log.md`). No project → `D:\Downloads\work-log.md`.
- Newest entry at the bottom. Format: `## YYYY-MM-DD HH:MM — <short title>` then bullets: request, actions (files/commands), result, not verified / open points.
- Log facts only (what actually ran and its outcome); never log secrets or passwords.
