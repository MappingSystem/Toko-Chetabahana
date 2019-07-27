#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh
chmod 600 /root/.ssh/*
id

echo "$hr\nSSH FILES\n$hr"
ls -lL /root/.ssh

if [ $PROJECT_ID = 'chetabahana' ]; then  
	echo "\n$hr\nAGENT\n$hr"
	eval `ssh-agent` && apt-get update > /dev/null
	apt-get --assume-yes install expect > /dev/null
	[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh 
	expect /root/.ssh/agent > /dev/null && ssh-add -l
fi

if [ $PROJECT_ID = 'marketleader' ]  
then 
	export GIT=https://chetabahana:`cat $HOME/.ssh/github_token`@github.com
	[ $REPO_NAME = 'Tutorial-Buka-Toko' ] && export BUILD='taxonomy'
else
	[ $BRANCH_NAME = 'master' ] && export tagname='chetabahana/branches'
fi

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD
