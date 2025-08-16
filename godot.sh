#!/usr/bin/env bash

nvim --server ./godothost --remote-send "<esc>:e $1<CR>"
