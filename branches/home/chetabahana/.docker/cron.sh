#!/bin/sh
WORKDIR=~/.docker/compose && cd $WORKDIR
if grep -Fqe "Image is up to date" << EOF
`docker pull chetabahana/saleor`
EOF
then
    rm -rf Tutorial-Buka-Toko
    eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l
    git clone git@github.com:MarketLeader/Tutorial-Buka-Toko.git
    cd Tutorial-Buka-Toko && git checkout master
    git remote add upstream git://github.com/mirumee/saleor.git
    git fetch --prune upstream
    if [ `git rev-list HEAD...upstream/master --count` -eq 0 ]
    then
        echo "all the same, do nothing"
    else
        echo "update exist, do branches!"
        git reset --hard upstream/master
        git push origin master --force
        cd ~/.config && rm -rf branches
        git clone git@github.com:Chetabahana/branches.git
        cp -frpT ~/.docker/branch branches/home/chetabahana/.docker/branch
        cp -frpT ~/.logs branches/home/chetabahana/.logs
        cd branches && export PWD=`pwd` && push
    fi
    cd $WORKDIR && rm -rf Tutorial-Buka-Toko
    eval `ssh-agent -k`
else
    echo "latest exist, do compose!"
    sh ~/.docker/init.sh
fi
