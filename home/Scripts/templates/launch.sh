#!/usr/bin/env bash

# Your session name
SESSION=""

# Session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
  # If launched from a terminal, attach immediately
  if [ -t 1 ]; then
    exec tmux attach -t "$SESSION"
  fi
  exit 0
fi


PROJECT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Create session + window 1
# -s "$SESSION"     \ # Session name
# -n root           \ # Initial window name
# -c "$PATH"          # Session working directory
tmux new-session -d \
  -s "$SESSION"     \
  -c "$PROJECT_DIR"

#############################################
# ====   Window actions   ================= #
# - replace n by a window index number      #
# - replace m by a window pane index number #
#############################################

# add a window
# tmux new-window \
#   -t "$SESSION":n
#   -n web
#   -c "$PROJECT_DIR"

# run a command - window specificity
# tmux send-keys -t "$SESSION":n 'some command' C-m

# split a window
# tmux split-window \
#   -v              \ # vertically
#   -h              \ # horizontally
#   -t "$SESSION":n \
#   -c              \ # working directory

# run a command - pane specificity
# tmux send-keys -t "$SESSION":n.m 'some command' C-m

# Starting window, default 1
tmux select-window -t "$SESSION":1

# If launched from a terminal, attach immediately
if [ -t 1 ]; then
  exec tmux attach -t "$SESSION"
fi
