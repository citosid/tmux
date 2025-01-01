#!/bin/bash
tmuxsessions=$(tmux list-sessions -F '#S#{?session_attached,attached,}' | grep -v attached)

tmux_switch_to_session() {
  session="$1"
  if [[ $tmuxsessions = *"$session"* ]]; then
    tmux switch-client -t "$session"
  fi

}
choice=$(sort -fu <<< "$tmuxsessions" \
  | fzf-tmux \
    -p \
    --info=hidden \
    --layout=reverse \
    --preview='~/.tmux/scripts/switch-session-preview.bash {}' \
    --prompt='💻 ' \
    --pointer=' ' \
  | tr -d '\n'
)

if [[ "${choice}" != "" ]]; then
  tmux_switch_to_session "$choice"
fi
