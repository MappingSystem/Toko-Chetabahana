#!/bin/sh

echo -e "$hr\nWHOAMI\n$hr"
whoami
echo -e $HOME
chmod 600 /root/.ssh/*
id

echo -e "$hr\nSSH FILES\n$hr"
ls -lL /root/.ssh

echo -e "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo -e "\n$hr\nSYSTEM INFO\n$hr"
gcloud info

echo -e "$hr\nPROJECT CONFIG\n$hr"
gcloud config list --all

echo -e "\n$hr\nFILE SYSTEM\n$hr"
df -h

echo -e "\n$hr\nRAM\n$hr"
cat /proc/meminfo

echo -e "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo -e "\n$hr\nALL REPOSITORY\n$hr"
pwd
ls -al /

echo -e "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

echo -e "\n$hr\nCF_VOLUME_PATH REPOSITORY\n$hr"
ls -al ${CF_VOLUME_PATH}