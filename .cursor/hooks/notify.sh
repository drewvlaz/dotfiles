#!/bin/bash
# Mirrors the Claude Code Notification hook: chime + highlight the tmux window.
cat >/dev/null

afplay /System/Library/Sounds/Glass.aiff -v 5 &

~/.dotfiles/.claude/tmux-alert.sh

echo '{}'
exit 0
