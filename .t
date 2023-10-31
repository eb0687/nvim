#!/usr/bin/env bash
tmux split-window -l 30%
tmux select-pane -t :.+
nvim -c 'Telescope find_files'
