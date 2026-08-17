# functions.zsh

# Edit files with fd + fzf
ef() {
    local search_dir="${1:-.}"

    local file
    file=$(fd -t f . "$search_dir" | fzf)

    [[ -n "$file" ]] && nvim-open "$file"
}

# Open files with fd + fzf
of() {
    local search_dir="${1:-.}"

    local file
    file=$(fd . "$search_dir" | fzf)

    [[ -n "$file" ]] && open "$file"
}

# Change directory with fd + fzf
cf() {
    local search_dir="${1:-.}"

    local dir
    dir=$(fd -t d . "$search_dir" | fzf)

    [[ -n "$dir" ]] && cd "$dir"
}

# nvim wrapper
nvim() {
    nvim-open "$@"
}

# For vifm to change dirs in macOS
VIFM_EXE="$(whence -p vifm)"

vifm() {
    local dir
    dir="$("$VIFM_EXE" --choose-dir - "$@")"

    [[ -d "$dir" ]] && cd "$dir"
}
