#!/bin/bash

switch_to_pane() {
  pane_id="$1"
  if [[ -n "$pane_id" ]]; then
    tmux switch-client -t "$pane_id"
  fi
}

# Format: store both display name and pane_id
panes=$(tmux list-panes -aF "#{pane_id}|#{pane_current_path}|#{pane_index}" | while IFS='|' read -r pane_id path pane_index; do
  # Extract relative path from home directory
  relative_path="${path#$HOME/}"
  echo "$relative_path - Pane $pane_index|$pane_id"
done)

choice=$(sort -fu <<< "$panes" \
  | fzf-tmux \
    -p \
    --info=hidden \
    --layout=reverse \
    --preview='~/.config/tmux/scripts/pane-preview.bash {}' \
    --prompt='📖 ' \
    --pointer=' ' \
  | tr -d '\n'
)

if [[ -n "$choice" ]]; then
  pane_id=$(echo "$choice" | awk -F'|' '{print $2}')
  switch_to_pane "$pane_id"
fi
