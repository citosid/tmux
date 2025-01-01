#!/usr/bin/env bash

if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
    tmux detach-client
else
    tmux popup -E "yazi ${1}"
fi