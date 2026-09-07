# nvim.ps1

if (! (Get-Command nvim -ErrorAction SilentlyContinue)) {
    return
}

# nvim wrapper
function nvim {
    nvim-open.cmd @args
}
