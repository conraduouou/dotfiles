# eza.zsh

if ! command -v eza &>/dev/null; then
    return
fi

# listing
alias ls='eza'
