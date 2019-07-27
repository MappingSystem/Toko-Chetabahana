#!/bin/sh

cd $HOME

#Environtment
USER=chetabahana
SHOP=Toko-Chetabahana
ORGANIZATION=MarketLeader

if [ $PROJECT_ID = 'chetabahana' ]; then  
	echo "\n$hr\nAGENT\n$hr"
	eval `ssh-agent` && apt-get update > /dev/null
	apt-get --assume-yes install expect > /dev/null
	[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh 
	expect /root/.ssh/agent > /dev/null && ssh-add -l
fi

echo "\n$hr\nSYNC\n$hr"
git clone git@github.com:Chetabahana/compose
git clone git@github.com:$ORGANIZATION/$SHOP.git

cd $HOME/$SHOP && git checkout $BRANCH_NAME
cd $HOME/compose && git checkout $BRANCH_NAME

rm -rf $HOME/$SHOP/compose
rm -rf $HOME/$SHOP/branches

cp -frpT /workspace $HOME/$SHOP/branches
cp -frpT $HOME/compose $HOME/$SHOP/compose

find $HOME/$SHOP/compose -name ".*" -exec rm -rfv {} \;
find $HOME/$SHOP/branches -name ".*" -exec rm -rfv {} \;

cd $HOME/$SHOP
cp -frpv $HOME/compose/cloudbuild.yaml .
git add . && git commit -m "sync source" && git status
[ "$BRANCH_NAME" = "master" ] && git push origin master --force

cd $HOME
rm -rf compose saleor $SHOP
eval `ssh-agent -k`
