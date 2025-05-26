#!/bin/bash

name=$(basename "$(tmux display-message -p '#{pane_current_path}')")
tmux rename-window "$name"
