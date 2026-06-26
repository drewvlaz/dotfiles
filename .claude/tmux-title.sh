#!/usr/bin/env bash
# Derives a stable tmux window title from the area of code being edited.
# Only fires on Edit/Write — outputs the project area, not the specific file.
# Scoped per tmux window to avoid cross-session interference.

# Resolve the pane — env var may not be set in async hook context
pane="${TMUX_PANE:-$(tmux display-message -p '#{pane_id}' 2>/dev/null)}"
[ -z "$pane" ] && exit 0

STATE_FILE="/tmp/claude-tmux-title-${pane//[^a-zA-Z0-9]/_}"

read -r json
fp=$(echo "$json" | jq -r '.tool_input.file_path // ""')
[ -z "$fp" ] && exit 0

# Extract the meaningful project area from the path.
area() {
    case "$fp" in
        */.claude/*|*/claude/*)
            echo "claude config" ;;
        */schema.prisma)
            echo "prisma" ;;
        *)
            # Find the first meaningful directory after src/lib/app
            local IFS='/'
            read -ra parts <<< "$fp"
            local anchor="src|lib|app"
            local skip="Users|home|dev|dist|build"
            local found=0 result=""
            for ((i=0; i<${#parts[@]}-1; i++)); do
                local seg="${parts[i]}"
                [[ -z "$seg" ]] && continue
                if [[ "$seg" =~ ^($anchor)$ ]]; then
                    found=1
                    continue
                fi
                if (( found )) && [[ ! "$seg" =~ ^($skip)$ ]] && [[ "$seg" != *.* ]]; then
                    result="$seg"
                    break
                fi
            done
            # fallback chain: meaningful dir > parent dir > project root
            if [ -z "$result" ]; then
                result=$(basename "$(dirname "$fp")")
            fi
            if [ -z "$result" ] || [ "$result" = "/" ] || [ "$result" = "." ]; then
                result=$(basename "$PWD")
            fi
            echo "$result"
            ;;
    esac
}

title=$(area)
[ -z "$title" ] && exit 0

# Only update if the title actually changed for this window
current=$(cat "$STATE_FILE" 2>/dev/null)
if [ "$title" != "$current" ]; then
    echo "$title" > "$STATE_FILE"
    tmux rename-window -t "$pane" "$title" 2>/dev/null || true
fi
