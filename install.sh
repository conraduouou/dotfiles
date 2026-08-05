#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Paths
################################################################################

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

################################################################################
# Helpers
################################################################################

install_homebrew() {

    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew already installed."
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

backup() {
    local target="$1"

    [[ ! -e "$target" ]] && return

    local timestamp
    timestamp="$(date +"%Y%m%d-%H%M%S")"

    echo "Backing up $target"

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
            echo "Already linked: $target"
            return
        fi

        echo "Removing old symlink: $target"
        rm "$target"
    fi

    backup "$target"

    ln -s "$REPO/$source" "$target"

    echo "Linked $target"
}

copy() {
    local source="$1"
    local target="$2"

    backup "$target"

    mkdir -p "$(dirname "$target")"

    cp -R "$REPO/$source" "$target"

    echo "Copied $target"
}

install_manifest() {

    local manifest="$1"

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
        echo ".gitconfig already configured."
        return
    fi

    cat >> "$gitconfig" <<EOF

# >>> dotfiles install >>>
[include]
    path = ~/.config/git/config
# <<< dotfiles install <<<
EOF

    echo "Updated .gitconfig"
}

################################################################################
# Install
################################################################################

main() {

    install_homebrew

    echo
    echo "Installing Homebrew packages..."
    echo

    brew bundle --file="$REPO/Brewfile"

    echo
    echo "Installing dotfiles..."
    echo

    install_manifest "common.manifest"
    install_manifest "macos.manifest"

    chmod +x "$HOME/.local/bin/open-file"

    append_git_include

    echo
    echo "Done!"
}

main "$@"
