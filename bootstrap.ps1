$ErrorActionPreference = "Stop"
$Dotfiles = "$env:USERPROFILE\.dotfiles"
$DotfilesRepo = "https://github.com/changyong-me/dotfiles.git"
$Principal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$Documents = [Environment]::GetFolderPath("MyDocuments")

function New-Link($Target, $Path) {
  New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
  if (Test-Path $Path) { (Get-Item $Path).Delete() }
  New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
}

function Copy-File($Source, $Path) {
  New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
  Copy-Item $Source $Path -Force
}

function Bootstrap {
  if (-not $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run from an administrator PowerShell."
  }

  if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
  }

  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    scoop install git
  }

  if (Test-Path "$Dotfiles\.git") {
    git -C $Dotfiles pull --ff-only
  } else {
    git clone $DotfilesRepo $Dotfiles
  }

  reg import "$Dotfiles\windows\registry.reg"
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
  & "$Dotfiles\windows\packages.ps1"

  New-Link  "$Dotfiles\codex\AGENTS.md"     "$env:USERPROFILE\.codex\AGENTS.md"
  Copy-File "$Dotfiles\codex\config.toml"   "$env:USERPROFILE\.codex\config.toml"
  New-Link  "$Dotfiles\codex\skills"        "$env:USERPROFILE\.codex\skills\user"
  New-Link  "$Dotfiles\git\.gitconfig"      "$env:USERPROFILE\.gitconfig"
  New-Link  "$Dotfiles\git\ignore"          "$env:USERPROFILE\.config\git\ignore"
  New-Link  "$Dotfiles\shell\profile.ps1"   "$Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
  New-Link  "$Dotfiles\shell\starship.toml" "$env:USERPROFILE\.config\starship.toml"
  New-Link  "$Dotfiles\zed\keymap.json"     "$env:APPDATA\Zed\keymap.json"
  New-Link  "$Dotfiles\zed\settings.json"   "$env:APPDATA\Zed\settings.json"

  Write-Host ""
  Write-Host "Bootstrap completed successfully!"
  Write-Host "Please restart your computer to apply all settings."
}

Bootstrap
