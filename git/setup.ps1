New-Item -ItemType SymbolicLink -Force -Path "$HOME/.gitconfig" -Target "$PSScriptRoot/.gitconfig" | Out-Null
