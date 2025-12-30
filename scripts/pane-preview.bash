#!/bin/bash

# Extract pane ID from the input (format: "pane_id | path - command")
pane_id=$(echo "$1" | awk -F' \| ' '{print $1}')
tmux capture-pane -ep -t "$pane_id"
