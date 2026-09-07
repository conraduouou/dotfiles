# fzf.ps1

if (! (Get-Command fzf -ErrorAction SilentlyContinue)) {
    return
}

if (! (Get-Command fd -ErrorAction SilentlyContinue)) {
    return
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

if (! (Get-Command nvim -ErrorAction SilentlyContinue)) {
    return
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
