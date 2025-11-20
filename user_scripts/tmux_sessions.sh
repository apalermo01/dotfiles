#!/usr/bin/env bash 


if [ "$#" -ne 1 ]; then
    exit 1
fi

active_sessions=$(tmux list-sessions)
