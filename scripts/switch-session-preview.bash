#!/bin/bash

echo $1 | sed 's/: .*$//' | xargs -I{} tmux capture-pane -ep -t {}
