#!/bin/sh

#Environtment
USER=chetabahana
REPO=Tutorial-Buka-Toko
ORGANIZATION=MarketLeader
LOCALHOST=localhost:8000
DOMAIN=www.chetabahana.com

echo "$hr\nMASTER\n$hr"
cd $HOME && rm -rf saleor
git clone $GIT/$USER/saleor.git saleor && cd saleor
git remote add upstream $GIT/$ORGANIZATION/$REPO.git
git pull upstream $BRANCH_NAME && git reset --hard upstream/$BRANCH_NAME

cd $HOME && cp -frpT /workspace saleor && cd saleor
find $BASEHOME/$USER -type d -name scripts -exec cp -frpT {} scripts \;
sed -i "s/-[0-9]\{1,\}-\([a-zA-Z0-9_]*\)'/-`date +%d%H%M`-cron'/g" cloudbuild.yaml

git status && git add . && git commit -m "Add support for $BUILD"
git push origin master --force

echo "$hr\nBUILD\n$hr"
SHOW=`git branch | grep -w $BUILD`
[ $? = 0 ] && git branch -D $BUILD

sleep 5 && git checkout master
sleep 10 && git checkout -B $BUILD

git pull origin master && git reset --hard origin/master
find saleor -type f -print0 | xargs -0 sed -i 's|"$LOCALHOST"|"$DOMAIN"|g'

git status && git add . && git commit -m "Add support for $BUILD"
git push origin $BUILD --force
