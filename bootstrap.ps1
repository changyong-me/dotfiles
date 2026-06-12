$ErrorActionPreference = "Stop"
$Dotfiles = "$env:USERPROFILE\.dotfiles"
$DotfilesRepo = "https://github.com/changyong-me/dotfiles.git"
$Principal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$Documents = [Environment]::GetFolderPath("MyDocuments")

function Link-Config($Target, $Path) {
  New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
  if (Test-Path $Path) { (Get-Item $Path).Delete() }
  New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
}

function Copy-Config($Source, $Path) {
  New-Item -ItemType Directory -Force -Path (Split-Path $Path) | Out-Null
  Copy-Item $Source $Path -Force
}

function Bootstrap {
  if (-not $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Run from an administrator PowerShell."
  }

  if (-not $PSCommandPath) {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
      Install-PackageProvider -Name NuGet -Force | Out-Null
      Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
      Repair-WinGetPackageManager -Force -Latest

      winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
      $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                  [Environment]::GetEnvironmentVariable("Path", "User")
    }

    if (Test-Path "$Dotfiles\.git") {
      git -C $Dotfiles pull --ff-only
    } else {
      git clone $DotfilesRepo $Dotfiles
    }
  }

  reg import "$Dotfiles\windows\registry.reg"
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
  & "$Dotfiles\windows\packages.ps1"

  Link-Config "$Dotfiles\codex\AGENTS.md"          "$env:USERPROFILE\.codex\AGENTS.md"
  Copy-Config "$Dotfiles\codex\config.toml"        "$env:USERPROFILE\.codex\config.toml"
  Link-Config "$Dotfiles\codex\skills"             "$env:USERPROFILE\.codex\skills\user"
  Link-Config "$Dotfiles\git\.gitconfig"           "$env:USERPROFILE\.gitconfig"
  Link-Config "$Dotfiles\git\ignore"               "$env:USERPROFILE\.config\git\ignore"
  Link-Config "$Dotfiles\shell\powershell.ps1"     "$Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
  Link-Config "$Dotfiles\shell\starship.toml"      "$env:USERPROFILE\.config\starship.toml"
  Link-Config "$Dotfiles\zed\keymap.json"          "$env:APPDATA\Zed\keymap.json"
  Link-Config "$Dotfiles\zed\settings.json"        "$env:APPDATA\Zed\settings.json"

  Write-Host ""
  Write-Host "Bootstrap completed successfully!"
  Write-Host "Please restart your computer to apply all settings."
}

Bootstrap
