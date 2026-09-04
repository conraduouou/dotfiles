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

check_gum() {

    if ! brew list gum &>/dev/null; then
        echo "This uninstall script uses $(gum_style "gum") to select plugins to remove."
        echo "Ensure it is installed before using this script."
        exit
    fi
}

unlink_if_mine() {

    local target="$1"

    [[ -L "$target" ]] || return

    local current
    current="$(readlink "$target")"

    if [[ "$current" != "$REPO"* ]]; then
        gum_style_fade "Skipped $target"
        return
    fi

    rm "$target"

    echo "Removed $(gum_style "$target")."
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

uninstall_packages() {

    BREWFILE=$REPO/Brewfile
    PACKAGES=$(sed -E -n '/brew|cask/s/.*"([^"]*)"/\1/p' "$BREWFILE" | grep -v "gum")

    HEADER="Choose packages to uninstall (this will remove them when you proceed)"
    PACKAGES_TO_REMOVE=$(echo "$PACKAGES" | gum choose --no-limit --header "$HEADER")
    echo

    if [[ -z "$PACKAGES_TO_REMOVE" ]]; then
        return
    fi

    echo "Removing $(gum_style "packages")..."

    echo "$PACKAGES_TO_REMOVE" | while read -r pkg; do
        brew uninstall "$pkg"
    done
}

remove_git_include() {

    local gitconfig="$HOME/.gitconfig"

    if [[ ! -f "$gitconfig" ]]; then
        gum_style_fade "Git include already removed."
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

    echo "Removed $(gum_style "Git include")."
}

remove_starshipfile() {

    local starshipfile="$HOME/.config/starship.toml"

    if [[ ! -f "$starshipfile" ]]; then
        gum_style_fade "Starship file already removed."
        return
    fi

    rm "$starshipfile"
    
    echo "Removed $(gum_style "Starship file")."
}

remove_vimplug() {

    local plugfile="$HOME/.config/vim/autoload/plug.vim"

    if [[ ! -f "$plugfile" ]]; then
        gum_style_fade "plug.vim already removed."
        return
    fi

    rm "$plugfile"

    echo "Removed $(gum_style "plug.vim file")."
}

remove_gum() {

    if ! gum confirm "Remove gum as well?"; then
        return
    fi

    if ! gum confirm "Really?"; then
        return
    fi

    if ! gum confirm "Are you reeeeeally sure? Gum is a GREAT package..."; then
        return
    fi

    gum_style_fade "Okay...."

    brew uninstall gum
    echo
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
# Uninstall
################################################################################

main() {

    check_gum

    sleep 3

    gum style --border double --border-foreground 212 --padding "1 6" "Remove-INATOR!"
    echo

    uninstall_packages
    echo

    uninstall_manifest "common.manifest"
    echo

    # remove plug.vim before unlinking vim directory
    remove_vimplug
    echo

    uninstall_manifest "macos.manifest"
    echo

    remove_git_include
    remove_starshipfile
    echo

    remove_gum

    if brew list gum &>/dev/null; then
        echo "We are $(gum_style "DONE")!"
    else
        echo "Done!"
    fi
}

main "$@"
