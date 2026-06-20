#!/usr/bin/env bash

set -euo pipefail
shopt -s dotglob nullglob

###################
# CONFIGURATION
###################

SYNC_PAIRS=(
    "$HOME/Dotfiles/home/Pictures:$HOME/Pictures"
    "$HOME/Dotfiles/home/dot/config:$HOME/.config"
    "$HOME/Dotfiles/home/dot/local:$HOME/.local"
)

###################
# HELPERS
###################

confirm() {
    local prompt="$1"
    local reply

    read -r -p "$prompt (y/n) " reply

    case "$reply" in
        [Yy]*) return 0 ;;
        *) return 1 ;;
    esac
}

absolute_path() {
    realpath "$1"
}

already_linked() {
    local target="$1"
    local source="$2"

    [[ -L "$target" ]] || return 1

    local current
    current="$(realpath "$target" 2>/dev/null || true)"

    [[ "$current" == "$source" ]]
}

###################
# FILE OPERATIONS
###################

remove_target_file() {
    local target="$1"

    if [[ -e "$target" || -L "$target" ]]; then
        if confirm "Replace '$target'?"; then
            rm -f "$target"
        else
            return 1
        fi
    fi
}

create_symlink() {
    local src="$1"
    local tgt="$2"

    ln -s "$src" "$tgt"

    echo "Linked:"
    echo "  $tgt"
    echo "  -> $src"
}

link_file() {
    local src="$1"
    local tgt="$2"

    local abs_src
    abs_src="$(absolute_path "$src")"

    if [[ -d "$tgt" ]]; then
        echo "Conflict: '$tgt' is a directory."
        return
    fi

    if already_linked "$tgt" "$abs_src"; then
        echo "Already linked: $tgt"
        return
    fi

    remove_target_file "$tgt" || {
        echo "Skipping '$src'"
        return
    }

    create_symlink "$abs_src" "$tgt"
}

###################
# DIRECTORY LOGIC
###################

ensure_directory() {
    local target="$1"

    if [[ -e "$target" && ! -d "$target" ]]; then
        echo "Conflict: '$target' exists and is not a directory."

        if confirm "Replace it with a directory?"; then
            rm -f "$target"
        else
            return 1
        fi
    fi

    mkdir -p "$target"
}

process_directory() {
    local src="$1"
    local tgt="$2"

    ensure_directory "$tgt" || {
        echo "Skipping directory '$src'"
        return
    }

    local child

    for child in "$src"/*; do
        [[ -e "$child" ]] || continue

        process_item \
            "$child" \
            "$tgt/$(basename "$child")"
    done
}

###################
# DISPATCHER
###################

process_item() {
    local src="$1"
    local tgt="$2"

    if [[ -d "$src" ]]; then
        process_directory "$src" "$tgt"

    elif [[ -f "$src" ]]; then
        link_file "$src" "$tgt"

    else
        echo "Skipping unsupported item: $src"
    fi
}

###################
# SYNC ENGINE
###################

run_sync_pair() {
    local pair="$1"

    local src="${pair%%:*}"
    local tgt="${pair##*:}"

    echo "Syncing:"
    echo "  $src -> $tgt"
    echo

    [[ -d "$src" ]] || {
        echo "Source missing: $src"
        return
    }

    process_item "$src" "$tgt"
    echo
}

###################
# MAIN
###################

main() {
    for pair in "${SYNC_PAIRS[@]}"; do
        run_sync_pair "$pair"
    done

    echo "Done."
}

main "$@"
