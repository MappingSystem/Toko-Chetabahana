#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo "$hr\nHOME SSH\n$hr"
ls -lL $HOME/.ssh

echo "$hr\nROOT SSH\n$hr"
ls -lL /root/.ssh

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo "\n$hr\nDOCKER VERSION\n$hr"
docker version

echo "\n$hr\nDOCKER INFO\n$hr"
docker info

echo "$hr\nIMAGE BUILDERS\n$hr"
docker images --all | sort

echo "\n$hr\nCURRENTLY RUNNING\n$hr"
docker ps

