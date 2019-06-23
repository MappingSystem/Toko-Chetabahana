#!/bin/sh
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose 
   docker-compose down --volumes
fi

cd ~/.docker
eval `ssh-agent` && expect ~/.ssh/agent

#avoid lack of update other than master
rm -rf branches compose Toko-Chetabahana
git clone git@github.com:Chetabahana/branches.git
git clone git@github.com:MarketLeader/Toko-Chetabahana.git

mv Toko-Chetabahana/compose . && rm -rf Toko-Chetabahana
mv -f branches/home/chetabahana/.ssh compose/home/chetabahana/

cd ~/.docker
rm -rf branches
eval `ssh-agent -k`

bash ~/.docker/compose/scripts/main.bash
(sleep 3; sudo reboot) &
