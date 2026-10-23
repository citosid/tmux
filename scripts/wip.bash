#!/bin/bash

# AI sessions picker (deja) for tmux run-shell: wip.bash [since], default 3d.
# The tmux server's PATH may lack deja (~/.local/bin) and jq/fzf (Homebrew).
for dir in "${HOME}/.local/bin" /opt/homebrew/bin; do
    case ":${PATH}:" in
    *":${dir}:"*) ;;
    *) PATH="${dir}:${PATH}" ;;
    esac
done
export PATH

source "${HOME}/dotfiles/scripts/functions.bash"

wip -s "${1:-3d}"
