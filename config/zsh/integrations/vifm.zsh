# vifm.zsh

if ! command -v vifm &>/dev/null; then
    return
fi

# For vifm to change dirs in macOS
VIFM_EXE="$(whence -p vifm)"

vifm() {
    local dir
    dir="$("$VIFM_EXE" --choose-dir - "$@")"

    [[ -d "$dir" ]] && cd "$dir"
}
