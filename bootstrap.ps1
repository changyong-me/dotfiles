$ErrorActionPreference = "Stop"
$Dotfiles = "$env:USERPROFILE\.dotfiles"
$DotfilesRepo = "https://github.com/changyong-me/dotfiles.git"
$Principal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()

function New-SymbolicLink($Target, $Path) {
  New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
  if (Test-Path $Path) { (Get-Item $Path).Delete() }
  New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
}

function Get-Dotfiles {
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

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
}

function Install-Dotfiles {
  reg import "$Dotfiles\windows\registry.reg"
  & "$Dotfiles\windows\packages.ps1"

  New-SymbolicLink "$Dotfiles\claude\skills"              "$env:USERPROFILE\.claude\skills"
  New-SymbolicLink "$Dotfiles\claude\CLAUDE.md"           "$env:USERPROFILE\.claude\CLAUDE.md"
  New-SymbolicLink "$Dotfiles\claude\settings.json"       "$env:USERPROFILE\.claude\settings.json"
  New-SymbolicLink "$Dotfiles\git\.gitconfig"             "$env:USERPROFILE\.gitconfig"
  New-SymbolicLink "$Dotfiles\git\ignore"                 "$env:USERPROFILE\.config\git\ignore"
  New-SymbolicLink "$Dotfiles\zed\keymap.json"            "$env:APPDATA\Zed\keymap.json"
  New-SymbolicLink "$Dotfiles\zed\settings.windows.jsonc" "$env:APPDATA\Zed\settings.json"
}

function Bootstrap {
  if (-not $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run from an administrator PowerShell."
  }

  Get-Dotfiles
  Install-Dotfiles

  Write-Host ""
  Write-Host "Bootstrap completed successfully!"
  Write-Host "Please restart your computer to apply all settings."
}

Bootstrap
