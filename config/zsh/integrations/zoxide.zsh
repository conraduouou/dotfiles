# zoxide.zsh

if ! command -v zoxide &>/dev/null; then
    return
fi

# init
eval "$(zoxide init zsh)"

alias cd='z'
