# nvim.zsh

if ! command -v nvim &>/dev/null; then
    return
fi

# nvim wrapper
nvim() {
    nvim-open "$@"
}
