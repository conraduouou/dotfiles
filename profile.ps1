# Put this under your ~/Documents/PowerShell directory

Invoke-Expression (& { (zoxide init powershell | Out-String) } )

$Env:Path = "$HOME\bin;" + $Env:Path

function vifm {
    & "$HOME\bin\vf.ps1" @args
}

Remove-Alias -Name cd
Set-Alias cd z

Remove-Alias -Name ls
Set-Alias ls eza

# For PSReadLine ergonomics
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# For PSReadLine controls
Set-PSReadLineKeyHandler -Chord Alt+j -Function NextHistory
Set-PSReadLineKeyHandler -Chord Alt+k -Function PreviousHistory
