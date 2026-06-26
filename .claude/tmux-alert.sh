#!/bin/bash
onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

# Highlight the tmux window tab when a Claude instance needs attention.
# Skips if the pane's window is already focused.
# Clears automatically when the window is next focused.

[ -z "$TMUX" ] && exit 0

pane="${TMUX_PANE:-$(tmux display-message -p '#{pane_id}' 2>/dev/null)}"
[ -z "$pane" ] && exit 0

window_id=$(tmux display-message -p -t "$pane" '#{window_id}')
active_window_id=$(tmux display-message -p '#{window_id}')

[ "$window_id" = "$active_window_id" ] && exit 0

tmux set-window-option -t "$window_id" window-status-format "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_yellow,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"

# Clear highlight when the window gets focused
tmux set-hook -g pane-focus-in \
  'set-window-option -u window-status-format'
