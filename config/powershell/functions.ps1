# functions.ps1

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
