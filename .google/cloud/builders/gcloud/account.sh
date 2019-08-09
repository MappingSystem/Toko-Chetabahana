#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nPROJECT CONFIG\n$hr"
gcloud config list --all

echo "\n$hr\nSYSTEM INFO\n$hr"
gcloud info

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

echo "\n$hr\nFILE SYSTEM\n$hr"
df -h

echo "\n$hr\nALL REPOSITORY\n$hr"
pwd
ls -al /

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

