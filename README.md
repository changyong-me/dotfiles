# Dotfiles

This repository manages personal dotfiles for reproducing the user's macOS development environment and Windows gaming desktop setup with consistent bootstrap scripts.

## Bootstrap

### macOS

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/changyong-me/dotfiles/main/bootstrap.sh)"
```

### Windows

Run from an **administrator** PowerShell:

```powershell
irm https://raw.githubusercontent.com/changyong-me/dotfiles/main/bootstrap.ps1 | iex
```
