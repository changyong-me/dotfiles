$ErrorActionPreference = "Stop"

function Install-App($Id, $Location) {
  $extra = if ($Location) { @("--location", $Location) } else { @() }
  winget install --id $Id -e --accept-source-agreements --accept-package-agreements @extra
}

Install-App AdGuard.AdGuard
Install-App Blizzard.BattleNet "${env:ProgramFiles(x86)}\Battle.net"
Install-App Discord.Discord
Install-App Google.Chrome
Install-App Microsoft.PowerShell
Install-App Modrinth.ModrinthApp
Install-App RazerInc.RazerInstaller.Synapse4
Install-App Starship.Starship
Install-App Valve.Steam
Install-App ZedIndustries.Zed
Install-App 9PLM9XGG6VKS # Codex

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
  $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
              [Environment]::GetEnvironmentVariable("Path", "User")
}

scoop bucket add nerd-fonts
scoop install nerd-fonts/Hack-NF 
scoop install nerd-fonts/D2Coding-NF
