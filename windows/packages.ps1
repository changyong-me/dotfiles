$ErrorActionPreference = "Stop"

function Add-ScoopBucket($Name) {
  if (-not (scoop bucket list | Where-Object Name -eq $Name)) {
    scoop bucket add $Name
  }
}

function Install-ScoopPackage($Name) {
  if (scoop list | Where-Object Name -eq ($Name -split "/")[-1]) {
    scoop update $Name
  } else {
    scoop install $Name
  }
}

function Install-WinGetPackage($Id, $Location) {
  $extra = if ($Location) { @("--location", $Location) } else { @() }
  winget install --id $Id -e --accept-source-agreements --accept-package-agreements @extra
}

Add-ScoopBucket nerd-fonts
Install-ScoopPackage gh
Install-ScoopPackage git
Install-ScoopPackage nerd-fonts/D2Coding-NF
Install-ScoopPackage nerd-fonts/Hack-NF

Install-PackageProvider -Name NuGet -Force | Out-Null
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
Repair-WinGetPackageManager -Force -Latest

Install-WinGetPackage AdGuard.AdGuard
Install-WinGetPackage Blizzard.BattleNet "${env:ProgramFiles(x86)}\Battle.net"
Install-WinGetPackage Discord.Discord
Install-WinGetPackage Google.Chrome
Install-WinGetPackage Modrinth.ModrinthApp
Install-WinGetPackage RazerInc.RazerInstaller.Synapse4
Install-WinGetPackage Valve.Steam
Install-WinGetPackage ZedIndustries.Zed
Install-WinGetPackage 9PLM9XGG6VKS # ChatGPT
