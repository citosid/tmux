#!/bin/bash

# Extract pane ID from the input (format: "path - Pane X|pane_id")
pane_id=$(echo "$1" | awk -F'|' '{print $2}')
tmux capture-pane -ep -t "$pane_id"
