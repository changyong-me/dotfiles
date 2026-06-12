$ErrorActionPreference = "Stop"

function Install-App($Id, $Location) {
  $extra = if ($Location) { @("--location", $Location) } else { @() }
  winget install --id $Id -e --accept-source-agreements --accept-package-agreements @extra
}

Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Repair-WinGetPackageManager -Force -Latest

Install-App AdGuard.AdGuard
Install-App Blizzard.BattleNet "${env:ProgramFiles(x86)}\Battle.net"
Install-App Discord.Discord
Install-App Google.Chrome
Install-App Modrinth.ModrinthApp
Install-App RazerInc.RazerInstaller.Synapse4
Install-App Valve.Steam
Install-App ZedIndustries.Zed
Install-App 9PLM9XGG6VKS # Codex

scoop bucket add nerd-fonts
scoop install nerd-fonts/D2Coding-NF
scoop install nerd-fonts/Hack-NF
scoop install pwsh
scoop install starship
