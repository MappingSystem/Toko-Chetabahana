#!/bin/bash

echo -e "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo -e "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo -e "$hr\nSSH FILES\n$hr"
ls -lL /root/.ssh

echo -e "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo -e "\n$hr\nALL REPOSITORY\n$hr"
ls -al /

echo -e "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .