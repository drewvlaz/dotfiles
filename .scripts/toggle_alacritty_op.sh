#!/usr/bin/env bash

## If alacritty.yml does not exist, raise an alert
[[ ! -f ~/.config/alacritty/alacritty.yml ]] && \
    notify-send "alacritty.yml does not exist" && exit 0

## Fetch background_opacity from alacritty.yml
opacity=$(awk '$1 == "opacity:" {print $2; exit}' ~/.config/alacritty/alacritty.yml)

## Assign toggle opacity value
case $opacity in
  1)
    toggle_opacity=0.85
    ;;
  *)
    toggle_opacity=1
    ;;
esac

## Replace opacity value in alacritty.yml
sed -i -- "s/opacity: $opacity/opacity: $toggle_opacity/" \
    ~/.config/alacritty/alacritty.yml
