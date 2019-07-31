#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nSSH FILES\n$hr"
[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh
chmod 600 /root/.ssh/*
ls -lL /root/.ssh

echo "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo "\n$hr\nALL REPOSITORY\n$hr"
ls -al /

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

echo "\n$hr\nCLONE ORIGIN\n$hr"
FLOWNAME=Toko-Chetabahana
WORKFLOW=$FLOWNAME/branches/.google
FLOW_GIT=git@github.com:MarketLeader/$FLOWNAME.git

REPO=$(basename $ORIGIN .git)
rm -rf $REPO && git clone $ORIGIN $REPO
find .io -type d -name $REPO -exec cp -frpvT {} $REPO \;

rm -rf $FLOWNAME && git clone $FLOW_GIT
cp -frpvT $WORKFLOW $REPO/.google

echo "\n$hr\nORIGIN REPOSITORY\n$hr"
ls -al $REPO
