Invoke-Expression (& { (zoxide init powershell | Out-String) } )

$Env:Path = "$HOME\bin;" + $Env:Path

# Edit files with fd and fzf
function ef {
    param(
        [string]$Path = "."
    )

    $files = @(fd -t f . $Path)

    $file = $files | fzf

    if ($file) {
        vim $file
    }
}

# Open files with fd and fzf
function of {
    param(
        [string]$Path = "."
    )

    $files = @(fd . $Path)

    $file = $files | fzf

    if ($file) {
        . $file
    }
}

# Change directory with fd and fzf
function cf {
    param(
        [string]$Path = "."
    )

    $dirs = @(fd -t d . $Path)

    $dir = $dirs | fzf

    if ($dir) {
        cd $dir
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
