# zoxide.ps1

if (! (Get-Command zoxide -ErrorAction SilentlyContinue)) {
    return
}

Invoke-Expression (& { (zoxide init powershell | Out-String) } )

Remove-Alias -Name cd
Set-Alias cd z
