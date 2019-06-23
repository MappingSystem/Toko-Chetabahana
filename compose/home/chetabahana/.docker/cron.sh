#!/bin/sh
WORKDIR=~/.config
#Todo: https://codefresh.io/docs/docs/configure-ci-cd-pipeline/triggers/dockerhub-triggers/
eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l
if grep -Fqe "Image is up to date" << EOF
`docker pull chetabahana/saleor`
EOF
then
    #Todo: https://github.com/upriver/upriver.github.io
	cd $WORKDIR && rm -rf Tutorial-Buka-Toko
    git clone git@github.com:MarketLeader/Tutorial-Buka-Toko.git
    cd Tutorial-Buka-Toko && git checkout master
    git remote add upstream git://github.com/mirumee/saleor.git
    git fetch --prune upstream
    if [ `git rev-list HEAD...upstream/master --count` -eq 0 ]
    then
        echo "all the same, do nothing"
    else
        #Todo: https://stackoverflow.com/questions/51915171 
        echo "update exist, do branches!"
        cd $WORKDIR && rm -rf branches
        git clone git@github.com:Chetabahana/branches.git
        cp -frpT ~/.docker/branch branches/home/chetabahana/.docker/branch
        cp -frpT ~/.logs branches/home/chetabahana/.logs
        cd branches && export PWD=`pwd` && push
        cd $WORKDIR && rm -rf branches
    fi
    cd $WORKDIR && rm -rf Tutorial-Buka-Toko
else
    #Todo: https://cloud.docker.com/repository/docker/chetabahana/saleor/webhooks
	echo "latest exist, do compose!"
    cd $WORKDIR && rm -rf compose
    git clone git@github.com:Chetabahana/compose.git
    cd compose && export PWD=`pwd` && push
    cd $WORKDIR && rm -rf compose
fi
eval `ssh-agent -k`
