# Windows

## Packages

- WinGet: `AdGuard.AdGuard`, `Blizzard.BattleNet`, `Discord.Discord`, `Git.Git`, `GitHub.cli`, `Google.Chrome`, `Modrinth.ModrinthApp`, `Spotify.Spotify`, `Starship.Starship`, `Valve.Steam`, `ZedIndustries.Zed`

## Settings

- The `sudo` command runs applications inline
- Local PowerShell scripts run without signing
- Caps Lock and Left Ctrl are swapped
- The Start menu shows no Recent or All section
- The taskbar shows no Search, Task view, or Widgets
- The taskbar is on the left of the screen
- Sticky keys has no keyboard shortcut
- Fast startup isn't turned on
- File Explorer opens to This PC
- File extensions are shown

## Symlinks

| Repository             | Destination                                                                  |
| ---------------------- | ---------------------------------------------------------------------------- |
| `claude/CLAUDE.md`     | `%USERPROFILE%\.claude\CLAUDE.md`                                            |
| `claude/settings.json` | `%USERPROFILE%\.claude\settings.json`                                        |
| `git/.gitconfig`       | `%USERPROFILE%\.gitconfig`                                                   |
| `git/ignore`           | `%USERPROFILE%\.config\git\ignore`                                           |
| `shell/profile.ps1`    | `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` |
| `shell/starship.toml`  | `%USERPROFILE%\.config\starship.toml`                                        |
| `zed/keymap.json`      | `%APPDATA%\Zed\keymap.json`                                                  |
| `zed/settings.json`    | `%APPDATA%\Zed\settings.json`                                                |
