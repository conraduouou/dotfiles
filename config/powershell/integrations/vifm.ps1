# vifm.ps1

if (! (Get-Command vifm -ErrorAction SilentlyContinue)) {
    return
}

# Override default vifm
function vifm {
    # Find vifm
    $vifmExe = (Get-Command vifm.exe).Source

    # Run vifm and capture the selected directory
    $dir = & $vifmExe --choose-dir - @args

    if (-not $dir) {
        return
    }

    $dir = $dir.Trim()

    if (Test-Path -LiteralPath $dir) {
        Set-Location -LiteralPath $dir
    }
    else {
        Write-Warning "Invalid directory returned by vifm: $dir"
    }
}
