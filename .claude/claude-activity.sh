#!/usr/bin/env bash
# Logs a one-liner per tool use to a per-pane activity file.
# Keeps last 20 lines so the preview stays relevant.

pane="${TMUX_PANE:-$(tmux display-message -p '#{pane_id}' 2>/dev/null)}"
[ -z "$pane" ] && exit 0

LOG="/tmp/claude-activity-${pane//[^a-zA-Z0-9]/_}.log"

read -r json
tool=$(echo "$json" | jq -r '.tool_name // ""')
input=$(echo "$json" | jq -r '.tool_input // empty')

case "$tool" in
    Edit|Write)
        fp=$(echo "$input" | jq -r '.file_path // ""')
        line="edit ${fp##*/}" ;;
    Read)
        fp=$(echo "$input" | jq -r '.file_path // ""')
        line="read ${fp##*/}" ;;
    Bash)
        cmd=$(echo "$input" | jq -r '.command // ""')
        line="${cmd:0:60}" ;;
    Grep)
        pat=$(echo "$input" | jq -r '.pattern // ""')
        line="grep ${pat:0:40}" ;;
    Glob)
        pat=$(echo "$input" | jq -r '.pattern // ""')
        line="glob ${pat:0:40}" ;;
    Agent)
        desc=$(echo "$input" | jq -r '.description // ""')
        line="agent: ${desc:0:50}" ;;
    *)
        line="$tool" ;;
esac

echo "$line" >> "$LOG"
tail -20 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
