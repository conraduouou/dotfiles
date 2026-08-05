#!/usr/bin/env bash

set -euo pipefail

################################################################################
# Paths
################################################################################

source "$REPO/dotfiles.sh"

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

    [[ -f "$gitconfig" ]] || return

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

################################################################################
# Uninstall
################################################################################

main() {

    echo
    echo "Uninstalling dotfiles..."
    echo

    uninstall_manifest "common.manifest"

    uninstall_manifest "macos.manifest"

    remove_git_include

    echo
    echo "Done!"
}

main "$@"
