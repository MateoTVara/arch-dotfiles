#!/usr/bin/env bash

PROJECTS_DIR="$HOME/Projects"

DIRECT_PROJECTS=(
  "$HOME/Dotfiles"
)

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
  find_projects "$PROJECTS_DIR"

  for dir in "${DIRECT_PROJECTS[@]}"; do
    [ -f "$dir/launch.sh" ] || continue
    printf '%s\n' "$dir"
  done
}

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

if [[ "$selected" == /* ]]; then
  project_dir="$selected"
else
  project_dir="$PROJECTS_DIR/$selected"
fi

cd "$project_dir" || exit 1

alacritty -e bash ./launch.sh &
