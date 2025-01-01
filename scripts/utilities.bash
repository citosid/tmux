#!/usr/bin/env bash

function tmux_switch_or_create_window() {
  local session_name=$1
  local window_name=$2
  local command=$3
  local working_dir=${4:-$PWD}

  local session_exists
  session_exists=$(tmux list-sessions 2>/dev/null | grep "^${session_name}:" || true)

  if [[ -n "${session_exists}" ]]; then
    local window_exists
    window_exists=$(tmux list-windows -t "${session_name}" 2>/dev/null | grep "${window_name}" || true)

    if [[ -n "${window_exists}" ]]; then
      tmux switch-client -t "${session_name}:${window_name}"
    else
      tmux new-window \
        -c "${working_dir}" \
        -t "${session_name}" \
        -n "${window_name}" \
        "${command}"
      tmux switch-client -t "${session_name}:${window_name}"
    fi
  else
    tmux new-session -d \
      -c "${working_dir}" \
      -s "${session_name}" \
      -n "${window_name}" \
      "${command}"
    tmux switch-client -t "${session_name}:${window_name}"
  fi
}

function fzf_select() {
  local prompt=$1
  shift
  local items=("$@")
  printf "%s\n" "${items[@]}" | fzf-tmux -p \
    --prompt="${prompt} " \
    --height=50% \
    --layout=reverse \
    --border \
    --exit-0 \
    --info=hidden
}
