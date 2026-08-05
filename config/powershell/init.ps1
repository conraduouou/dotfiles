# init.ps1

# essentials
. ~/.config/powershell/path.ps1
. ~/.config/powershell/env.ps1

# workflow
. ~/.config/powershell/prompt.ps1
. ~/.config/powershell/aliases.ps1
. ~/.config/powershell/functions.ps1

Invoke-Expression (& { (zoxide init powershell | Out-String) } )

# For PSReadLine ergonomics
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# For PSReadLine controls
Set-PSReadLineKeyHandler -Chord Alt+j -Function NextHistory
Set-PSReadLineKeyHandler -Chord Alt+k -Function PreviousHistory
