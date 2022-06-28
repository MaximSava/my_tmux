#!/bin/sh

# Set Session Name
SESSION="undercloud"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
   tmux new-session -s undercloud \; \
     split-window -v \; \
     select-pane -t 0 \; \
     split-window -h \; \
     select-pane -t 0 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m 'ssh heat-admin@controller-0.ctlplane' C-m \; \
     select-pane -t 1 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m 'ssh heat-admin@controller-2.ctlplane' C-m \; \
     select-pane -t 2 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m  \;

fi