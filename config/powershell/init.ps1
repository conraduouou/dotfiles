# init.ps1

# essentials
. ~/.config/powershell/path.ps1
. ~/.config/powershell/env.ps1

# workflow
. ~/.config/powershell/prompt.ps1
. ~/.config/powershell/aliases.ps1
. ~/.config/powershell/functions.ps1

# integrations
. ~/.config/powershell/integrations/starship.ps1
. ~/.config/powershell/integrations/zoxide.ps1
. ~/.config/powershell/integrations/fzf.ps1
. ~/.config/powershell/integrations/eza.ps1
. ~/.config/powershell/integrations/vifm.ps1
. ~/.config/powershell/integrations/nvim.ps1

# For PSReadLine ergonomics
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# For PSReadLine controls
Set-PSReadLineKeyHandler -Chord Ctrl+j -Function NextHistory
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function PreviousHistory

# For vi edit mode in all shells
Set-PSReadLineOption -EditMode Vi
