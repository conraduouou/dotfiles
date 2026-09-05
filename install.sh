#!/usr/bin/env bash

set -euo pipefail

# this particular code can be removed if the following PR is resolved:
# https://github.com/charmbracelet/gum/pull/1142
export CLICOLOR_FORCE=1

################################################################################
# Paths
################################################################################

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

################################################################################
# Helpers
################################################################################

install_homebrew() {

    if command -v brew &>/dev/null; then
        return
    fi

    echo "Installing Homebrew..."

    NONINTERACTIVE=1 \
    /bin/bash -c "$(
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    )"

    # Apple Silicon
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    # Intel Macs
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

install_gum() {

    if brew list gum &>/dev/null; then
        return
    fi

    echo "Installing gum..."

    brew install gum
}

install_packages() {

    BREWFILE=$REPO/Brewfile
    PACKAGES="$(sed -E -n '/brew|cask/s/.*"([^"]*)"/\1/p' "$BREWFILE")"

    HEADER="Choose packages to install (This will install them when you proceed)"
    PACKAGES_TO_INSTALL=$(echo "$PACKAGES" | gum choose --no-limit --header "$HEADER" --selected "*")

    cp "$BREWFILE" "$BREWFILE-temp"

    grep "$PACKAGES_TO_INSTALL" "$BREWFILE-temp" > "$BREWFILE"

    echo "$(gum_style "brew bundle") is running..."
    brew bundle

    rm "$BREWFILE"
    mv "$BREWFILE-temp" "$BREWFILE"
}

welcome() {

    gum style --border-foreground 212 --border double --padding "1 6" "Hello $USER!"
    echo

    HEADER="Ready to install $(gum_style "dotfiles")?"
    CHOICE=$(gum choose "Yes" "No" --header "$HEADER")
    echo

    echo "Doesn't matter... We're going to install $(gum style --italic --foreground 212 anyway!)"
}

backup() {

    local target="$1"

    [[ ! -e "$target" ]] && return

    local timestamp
    timestamp="$(date +"%Y%m%d-%H%M%S")"

    gum_style_fade "Backing up $target"

    mv "$target" "$target.backup-$timestamp"
}

link() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        local current
        current="$(readlink "$target")"

        # Already linked to our dotfiles? Nothing to do.
        if [[ "$current" == "$REPO/$source" ]]; then
            gum_style_fade "Already linked: $target"
            return
        fi

        gum_style_fade "Removing old symlink: $target"
        rm "$target"
    fi

    backup "$target"

    ln -s "$REPO/$source" "$target"

    echo "Linked $(gum_style "$target")"
}

copy() {
    local source="$1"
    local target="$2"

    backup "$target"

    mkdir -p "$(dirname "$target")"

    cp -R "$REPO/$source" "$target"

    gum_style_fade "Copied $target"
}

install_manifest() {

    local manifest="$1"

    echo "Installing $(gum_style "$1")..."

    while IFS='|' read -r source target
    do
        # Trim leading/trailing whitespace
        source="$(xargs <<< "$source")"
        target="$(xargs <<< "$target")"

        # Skip blank lines
        [[ -z "$source" ]] && continue

        # Skip comments
        [[ "$source" =~ ^# ]] && continue

        # Skip malformed lines
        [[ -z "$target" ]] && continue

        link "$source" "$HOME/$target"

    done < "$REPO/manifest/$manifest"
}

append_git_include() {

    local gitconfig="$HOME/.gitconfig"

    touch "$gitconfig"

    # Already installed?
    if grep -Fq "# >>> dotfiles install >>>" "$gitconfig"; then
        gum_style_fade ".gitconfig already configured."
        return
    fi

    cat >> "$gitconfig" <<EOF

# >>> dotfiles install >>>
[include]
    path = ~/.config/git/config
# <<< dotfiles install <<<
EOF

    echo "Updated $(gum_style ".gitconfig.")"
}

install_starshipfile() {

    local starshipfile="$HOME/.config/starship.toml"

    if [ -f "$starshipfile" ]; then
        gum_style_fade "Starship preset already installed."
        return
    fi

    starship preset pure-preset -o "$starshipfile"

    echo "Installed $(gum_style "starship pure preset")."
}

install_vimplug() {

    local plugfile="$HOME/.config/vim/autoload/plug.vim"

    if [ -f "$plugfile" ]; then
        gum_style_fade "plug.vim already installed."
        return
    fi

    curl -fLo "$plugfile" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Installed $(gum_style "plug.vim")."
}

gum_style() {

    text=$1

    if (( $# >= 2 )); then
        color=$2
    fi

    gum style --foreground "${color:-212}" "$text"
}

gum_style_fade() {
    
    text=$1

    if (( $# >= 2 )); then
        color=$2
    fi

    gum style --foreground "${color:-241}" "$text"
}

################################################################################
# Install
################################################################################

main() {

    # Step 1: check if homebrew is installed
    install_homebrew
    echo

    # Step 2: check if gum is installed on home brew
    install_gum
    echo

    # Step 3: Perform gum operations
    welcome
    echo

    sleep 1

    # Step 4: commence installation of picked packages
    install_packages
    echo

    # Step 5: commence installation of symlinks
    install_manifest "common.manifest"
    echo

    install_manifest "macos.manifest"
    echo

    # Step 6: do miscellaneous things
    append_git_include
    install_starshipfile
    install_vimplug
    echo

    echo "We are $(gum_style "DONE")!"
    echo
}

main "$@"
