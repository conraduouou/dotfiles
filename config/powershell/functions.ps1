# functions.ps1

# nvim wrapper
function nvim {
    nvim-open.cmd @args
}

# Edit files with fd + fzf
function ef {
    param(
        [string]$Path = "."
    )

    $files = @(fd -t f . $Path)

    $file = $files | fzf

    if ($file) {
        nvim $file
    }
}

# Open files with fd + fzf
function of {
    param(
        [string]$Path = "."
    )

    $files = @(fd . $Path)

    $file = $files | fzf

    if ($file) {
        Start-Process $file
    }
}

# Change directory with fd + fzf
function cf {
    param(
        [string]$Path = "."
    )

    $dirs = @(fd -t d . $Path)

    $dir = $dirs | fzf

    if ($dir) {
        Set-Location $dir
    }
}

# Lock the session
function lock {
    rundll32.exe user32.dll,LockWorkStation
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
