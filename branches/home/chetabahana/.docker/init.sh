#!/bin/sh
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose 
   docker-compose down --volumes
fi

cd ~/.docker && sudo rm -rf compose
eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l
git clone git@github.com:Chetabahana/compose.git
eval `ssh-agent -k`

cd ~/.docker/compose/scripts && chmod -R +x *
find . -type f -name '*.sh' | sort | sh > compose.log
mv -f compose.log ~/.logs/ && cat ~/.logs/compose.log

(sleep 3; sudo reboot) &
