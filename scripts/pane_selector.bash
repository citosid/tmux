#!/usr/bin/env bash

source "${HOME}/.config/tmux/scripts/utilities.bash"

function get_panes() {
  local -a panes
  mapfile -t panes < <(tmux list-panes -aF "#{pane_current_path} :#{pane_id}")
  
  local pane_selected
  pane_selected=$(fzf_select "📖" "${panes[@]}")
  [[ -z "${pane_selected}" ]] && return
  
  local pane_id
  pane_id=$(echo "${pane_selected}" | awk -F':' '{print $2}')
  tmux switch-client -t "${pane_id}"
}

get_panes
