# eza.ps1

if (! (Get-Command eza -ErrorAction SilentlyContinue)) {
    return
}

Remove-Alias -Name ls
Set-Alias ls eza
