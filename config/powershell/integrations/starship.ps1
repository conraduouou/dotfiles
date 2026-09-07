# starship.ps1

if (! (Get-Command starship -ErrorAction SilentlyContinue)) {
    return
}

&starship init powershell | Invoke-Expression
