#!/usr/bin/env bash
# List all tmux panes running claude, with fzf preview. Enter jumps to selection.

panes=$(tmux list-panes -a -F '#{window_index}|#{pane_id}|#{session_name}:#{window_index}.#{pane_index}|#{pane_title}|#{pane_current_path}|#{pane_current_command}' \
    | awk -F'|' '$6 ~ /^claude$/ || $6 ~ /^node$/ && $4 ~ /Claude Code|✳|⠐|⠂|⠁|⡀|⠄|⠠|⠃|⠅|⠆/' \
    | while IFS='|' read -r widx pane_id target title path cmd; do
        log="/tmp/claude-activity-${pane_id//[^a-zA-Z0-9]/_}.log"
        mtime=$(stat -f '%m' "$log" 2>/dev/null || echo 0)
        echo "${mtime}|${pane_id}|${target}|${title}|${path}|${cmd}"
      done \
    | sort -t'|' -k1,1rn \
    | cut -d'|' -f2-)

if [ -z "$panes" ]; then
    echo "No claude panes found"
    sleep 1
    exit 0
fi

# Write pane titles to tmp so preview can look them up
titles_file="/tmp/claude-pane-titles"
echo "$panes" | awk -F'|' '{ print $1 "|" $3 }' > "$titles_file"

selected=$(echo "$panes" \
    | awk -F'|' '{ n=split($4,a,"/"); dir=a[n]; printf "%-8s %-15s %s\n", $1, dir, $3 }' \
    | fzf --no-sort \
          --reverse \
          --with-nth '2..'
          --bind 'j:down,k:up' \
          --header 'claude instances' \
          --preview 'pane={1}; title=$(grep "^${pane}|" /tmp/claude-pane-titles | cut -d"|" -f2); echo "$title"; echo ""; f="/tmp/claude-activity-${pane//[^a-zA-Z0-9]/_}.log"; cat "$f" 2>/dev/null || echo "no activity yet"' \
          --preview-window 'right:60%:wrap' \
          --height=100% \
          --no-border)

[ -z "$selected" ] && exit 0

pane_id=$(echo "$selected" | awk '{print $1}')
tmux switch-client -t "$pane_id"
