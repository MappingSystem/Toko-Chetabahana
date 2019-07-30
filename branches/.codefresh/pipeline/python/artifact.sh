#!/bin/sh

echo "$hr\nWHOAMI\n$hr"
whoami
echo $HOME
id

echo "$hr\nSSH FILES\n$hr"
cp -frpT $ROOT /root
chmod 600 /root/.ssh/*
ls -lL /root

echo "\n$hr\nHOME PROFILES\n$hr"
ls -al $HOME

echo "\n$hr\nALL REPOSITORY\n$hr"
ls -al /

echo "\n$hr\nCURRENT REPOSITORY\n$hr"
pwd
ls -al .

echo "\n$hr\nCF_VOLUME_PATH REPOSITORY\n$hr"
ls -al ${CF_VOLUME_PATH}
