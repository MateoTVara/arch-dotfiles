#!/usr/bin/env bash

PROJECTS_DIR="$HOME/Projects"

DIRECT_PROJECTS=(
    "$HOME/Dotfiles"
)

############################
# Project discovery
############################

find_projects() {
    local dir="$1"

    for entry in "$dir"/*; do
        [ -d "$entry" ] || continue

        if [ -f "$entry/launch.sh" ]; then
            realpath --relative-to="$PROJECTS_DIR" "$entry"
        else
            find_projects "$entry"
        fi
    done
}

list_projects() {
    echo "general"

    find_projects "$PROJECTS_DIR"

    for dir in "${DIRECT_PROJECTS[@]}"; do
            [ -f "$dir/launch.sh" ] || continue
            printf '%s\n' "$dir"
    done
}

############################
# Selection
############################

selected=$(
    list_projects |
    sort |
    rofi -dmenu -p "Project:" -theme-str '
        prompt {
        padding: 0px;
        margin: 0px 4px 0px 0px;
        }
        element-icon {
        size: 0px;
        margin: 0px;
        }
    '
)

[ -n "$selected" ] || exit 0

############################
# Resolve project dir
############################

if [[ "$selected" == "general" ]]; then
    project_dir="$HOME"
elif [[ "$selected" == /* ]]; then
    project_dir="$selected"
else
    project_dir="$PROJECTS_DIR/$selected"
fi

cd "$project_dir" || exit 1

############################
# Launch logic
############################

launch_general_tmux() {
    tmux has-session -t general 2>/dev/null || \
        tmux new-session -d -s general -c "$HOME"

    alacritty -e tmux attach -t general &
}

if [[ "$selected" == "general" ]]; then
    launch_general_tmux
    exit 0
fi

############################
# Project launch.sh logic
############################

if [[ -f "$project_dir/launch.sh" ]]; then
    alacritty -e bash ./launch.sh &
else
    alacritty &
fi
