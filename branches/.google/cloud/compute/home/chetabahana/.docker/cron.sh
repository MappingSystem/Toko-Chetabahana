#!/bin/sh

TASKNAME=Cloud-Tasks-API
FLOWNAME=Toko-Chetabahana
TASKFLOW=~/.gits/$TASKNAME
BASENAME=Tutorial-Buka-Toko
WORKFLOW=~/.gits/$FLOWNAME/branches
UPSTREAM=git@github.com:mirumee/saleor.git
TASK_GIT=git@github.com:MarketLeader/$TASKNAME.git
FLOW_GIT=git@github.com:MarketLeader/$FLOWNAME.git

eval `ssh-agent`
cd ~/.gits/$BASENAME
expect ~/.ssh/agent > /dev/null

[ `git rev-parse --abbrev-ref HEAD` != master ] && git checkout master

if grep -q $UPSTREAM << EOF
`git remote -v`
EOF
then
    git remote set-url upstream $UPSTREAM
else
    git remote add upstream $UPSTREAM
fi

git fetch --prune upstream
[ -z "${1}" ] && COUNTER=0 || COUNTER=${1}
if [ `git rev-list HEAD...upstream/master --count` -eq $COUNTER ]
then
    echo "all the same, do regular things"
else
    echo "update exist, let's checking!"
    git pull --rebase upstream master
	git reset --hard upstream/master
	for i in $TASKNAME $FLOWNAME; do
	    ORIGIN=git@github.com:MarketLeader/$i.git
		cd ~/.gits/$i && git remote set-url origin $ORIGIN
		git pull origin master
	done
	cp -frpT $WORKFLOW $TASKFLOW
	cd ~/.gits/$TASKNAME
	push $TASK_GIT
fi
eval `ssh-agent -k`
