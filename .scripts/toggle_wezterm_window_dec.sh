#!/usr/bin/env bash

## If config file does not exist, raise an alert
[[ ! -f ~/.wezterm.lua ]] &&
  notify-send ".wezterm.lua does not exist" && exit 0

## Fetch current window_decorations value
window_decorations=$(awk '$1 == "config.window_decorations" && $2 == "=" {print $3 $4 $5}' ~/.wezterm.lua)

## Assign toggle value
case $window_decorations in
"\"RESIZE\"")
  toggle_window_decorations="\"TITLE | RESIZE\""
  ;;
*)
  window_decorations="\"TITLE | RESIZE\""
  toggle_window_decorations="\"RESIZE"\"
  ;;
esac

## Replace value in .wezterm.lua
sed -i -- "s/config.window_decorations = $window_decorations/config.window_decorations = $toggle_window_decorations/" \
  ~/.dotfiles/.wezterm.lua
