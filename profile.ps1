# Put this under your ~/Documents/PowerShell directory

Invoke-Expression (& { (zoxide init powershell | Out-String) } )

$Env:Path = "$HOME\bin;" + $Env:Path

function vifm {
    & "$HOME\bin\vf.ps1" @args
}

function ff {
    $files = @(fd)

    $file = $files | fzf

    if ($file) {
        vim $file
    }
}

function of {
    $files = @(fd)

    $file = $files | fzf

    if ($file) {
        . $file
    }
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

# For fzf controls and options
# $env:FZF_DEFAULT_OPTS = '--bind=alt-j:down --bind=alt-k:up --preview="cmd /c bat --color=always --style=numbers {}" --preview-window=right:60%'
