New-Item -ItemType Directory -Force "$HOME/.codex/skills" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$HOME/.codex/skills/user" -Target "$PSScriptRoot/skills" | Out-Null
New-Item -ItemType SymbolicLink -Force -Path "$HOME/.codex/AGENTS.md" -Target "$PSScriptRoot/AGENTS.md" | Out-Null
Copy-Item -Force "$PSScriptRoot/config.toml" "$HOME/.codex/config.toml"
