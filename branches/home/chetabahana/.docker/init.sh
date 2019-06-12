#!/bin/sh
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose 
   docker-compose down --volumes
fi

cd ~/.docker && rm -rf compose
eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l
git clone git@github.com:Chetabahana/compose.git

cd ~/.docker/compose/scripts && chmod -R +x *
find . -type f -name '*.sh' | sort | sh > compose.log

eval `ssh-agent -k` && (sleep 3; sudo reboot) &
