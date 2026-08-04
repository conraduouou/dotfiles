# functions.zsh

# Edit files with fd + fzf
ef() {
    local path="${1:-.}"

    local file
    file=$(fd -t f . "$path" | fzf)

    [[ -n "$file" ]] && vim "$file"
}

# Open files with fd + fzf
of() {
    local path="${1:-.}"

    local file
    file=$(fd . "$path" | fzf)

    [[ -n "$file" ]] && open "$file"
}

# Change directory with fd + fzf
cf() {
    local path="${1:-.}"

    local dir
    dir=$(fd -t d . "$path" | fzf)

    [[ -n "$dir" ]] && cd "$dir"
}

# For vifm to change dirs in macOS
VIFM_EXE="$(whence -p vifm)"

vifm() {
    local dir
    dir="$("$VIFM_EXE" --choose-dir - "$@")"

    [[ -d "$dir" ]] && cd "$dir"
}
