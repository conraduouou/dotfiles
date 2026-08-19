#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Paths
################################################################################

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

################################################################################
# Helpers
################################################################################

unlink_if_mine() {

    local target="$1"

    [[ -L "$target" ]] || return

    local current
    current="$(readlink "$target")"

    if [[ "$current" != "$REPO"* ]]; then
        echo "Skipped $target"
        return
    fi

    rm "$target"

    echo "Removed $target"
}

uninstall_manifest() {

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

        unlink_if_mine "$HOME/$target"

    done < "$REPO/manifest/$manifest"

}

remove_git_include() {

    local gitconfig="$HOME/.gitconfig"

    if [[ ! -f "$gitconfig" ]]; then
        echo "Git include already removed."
        return
    fi

    local temp
    temp="$(mktemp)"

    awk '
    /# >>> dotfiles install >>>/ { skip=1; next }
    /# <<< dotfiles install <<</ { skip=0; next }

    !skip
    ' "$gitconfig" > "$temp"

    mv "$temp" "$gitconfig"

    echo "Removed Git include."
}

remove_starshipfile() {

    local starshipfile="$HOME/.config/starship.toml"

    if [[ ! -f "$starshipfile" ]]; then
        echo "Starship file already removed."
        return
    fi

    rm "$starshipfile"
    
    echo "Removed Starship file."
}

remove_vimplug() {

    local plugfile="$HOME/.config/vim/autoload/plug.vim"

    if [[ ! -f "$plugfile" ]]; then
        echo "plug.vim already removed."
        return
    fi

    rm "$plugfile"

    echo "Removed plug.vim file"
}

################################################################################
# Uninstall
################################################################################

main() {

    echo
    echo "Uninstalling dotfiles..."
    echo

    uninstall_manifest "common.manifest"

    # remove plug.vim before unlinking vim directory
    remove_vimplug

    uninstall_manifest "macos.manifest"

    remove_git_include
    remove_starshipfile

    echo
    echo "Done!"
}

main "$@"
