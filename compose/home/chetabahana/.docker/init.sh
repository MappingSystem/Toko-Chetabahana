#!/bin/sh
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose 
   docker-compose down --volumes
fi

cd ~/.docker && sudo rm -rf compose
eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l
git clone git@github.com:Chetabahana/compose.git
eval `ssh-agent -k`

bash ~/.docker/compose/scripts/main.bash

(sleep 3; sudo reboot) &
