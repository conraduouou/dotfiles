# functions.zsh

# nvim wrapper
nvim() {
    nvim-open "$@"
}

# Edit files with fd + fzf
ef() {
    local search_dir="${1:-.}"

    local file
    file=$(fd -t f . "$search_dir" | fzf --tmux)

    if [[ -n "$file" ]]; then
        if [[ -n "${TMUX:-}" ]]; then
            nvim "$file" &>/dev/null &!
        else
            nvim "$file"
        fi
    fi
}

# Open files with fd + fzf
of() {
    local search_dir="${1:-.}"

    local file
    file=$(fd . "$search_dir" | fzf --tmux)

    [[ -n "$file" ]] && open "$file" &>/dev/null &!
}

# Change directory with fd + fzf
cf() {
    local search_dir="${1:-.}"

    local dir
    dir=$(fd -t d . "$search_dir" | fzf --tmux)

    [[ -n "$dir" ]] && cd "$dir"
}

# For vifm to change dirs in macOS
VIFM_EXE="$(whence -p vifm)"

vifm() {
    local dir
    dir="$("$VIFM_EXE" --choose-dir - "$@")"

    [[ -d "$dir" ]] && cd "$dir"
}
