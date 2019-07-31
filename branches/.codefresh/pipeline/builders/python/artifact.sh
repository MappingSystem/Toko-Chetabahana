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
REPO=$(basename $ORIGIN .git)
rm -rf $REPO && git clone $ORIGIN $REPO
find .io -type d -name $REPO -exec cp -frpvT {} $REPO \;

FLOWNAME=Toko-Chetabahana
WORKFLOW=$FLOWNAME/branches/.google
FLOW_GIT=https://github.com/MarketLeader/$FLOWNAME.git

rm -rf $FLOWNAME && git clone $FLOW_GIT
cp -frpvT $WORKFLOW $REPO/.google

echo "\n$hr\nORIGIN REPOSITORY\n$hr"
cd $REPO && ls -al .

echo "\n$hr\nUPDATE\n$hr"
apt-get -y update \
  && apt-get install -y gettext \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo "\n$hr\nPIPENV\n$hr"
pip install --upgrade pip
pip install --upgrade setuptools
pip install --user pipenv

echo "\n$hr\nBIN FILES\n$hr"
VENV=`pipenv --venv`
ln -s $HOME/.ssh/push $VENV/bin/push
pipenv run chmod +x /bin/push
ls -al $VENV/bin
cat Pipfile