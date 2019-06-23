#!/bin/sh
repo=Tutorial-Buka-Toko
token=`cat ~/.ssh/github_token`
saleor=github.com/mirumee/saleor.git
tutorial=github.com/MarketLeader/$repo.git
origin=https://chetabahana:$token@$tutorial
upstream=https://chetabahana:$token@$saleor

eval `ssh-agent`
expect ~/.ssh/agent

cd ~/.gits/$repo
git remote rm origin
git remote rm upstream
git remote add origin $origin
git remote add upstream $upstream

git checkout master
git pull --rebase upstream master
git reset --hard upstream/master
git push origin master

eval `ssh-agent -k`
