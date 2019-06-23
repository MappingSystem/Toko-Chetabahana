#!/bin/sh
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose 
   docker-compose down --volumes
fi

cd ~/.docker
sudo rm -rf compose Toko-Chetabahana
eval `ssh-agent` && expect ~/.ssh/agent

#avoid lack of update other than master
git clone git@github.com:Chetabahana/compose.git
git clone git@github.com:MarketLeader/Toko-Chetabahana.git
mv -f compose/home/chetabahana/.ssh Toko-Chetabahana/compose/home/chetabahana/

cd ~/.docker
rm -rf compose
mv Toko-Chetabahana/compose .
rm -rf Toko-Chetabahana
eval `ssh-agent -k`

bash ~/.docker/compose/scripts/main.bash
(sleep 3; sudo reboot) &
