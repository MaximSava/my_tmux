#!/bin/sh

# Set Session Name
SESSION="undercloud1"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)
scp ~/aliases/alias stack@undercloud-0:~/

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
   tmux new-session -s undercloud1 \; \
     split-window -v \; \
     select-pane -t 0 \; \
     split-window -h \; \
     select-pane -t 0 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m 'ssh heat-admin@controller-0.ctlplane' C-m \; \
     select-pane -t 1 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m 'ssh heat-admin@controller-2.ctlplane' C-m \; \
     select-pane -t 2 \; \
     send-keys  'sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0' C-m 'source ~/alias' C-m  \;

fi

sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0 sudo yum install -y vim
sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0 git clone https://github.com/openstack/tempest.git
sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0 git clone https://opendev.org/openinfra/python-tempestconf.git
sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0 git clone https://github.com/tox-dev/tox.git
sudo ssh -o "StrictHostKeyChecking no" stack@undercloud-0 git clone https://opendev.org/openstack/glance-tempest-plugin.git


#create venv environment for tempest

#create workspace for tempest
