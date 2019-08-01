#!/bin/sh

#Environtment
SHOP=Toko-Chetabahana
ORGANIZATION=MarketLeader
DIR=$HOME/$SHOP/$REPO_NAME

[ $HOME != /root ] && ln -s $HOME/.ssh /root/.ssh

if [ -f /root/.ssh/id_rsa ]
then  
	echo "\n$hr\nAGENT\n$hr"
	eval `ssh-agent` && apt-get update > /dev/null
	apt-get --assume-yes install expect > /dev/null
	expect /root/.ssh/agent > /dev/null && ssh-add -l
fi

cd $HOME
echo "\n$hr\nSYNC\n$hr"
git clone git@github.com:$ORGANIZATION/$SHOP.git

cd $HOME/$SHOP
if grep -q origin/$BRANCH_NAME << EOF
`git branch -r`
EOF
then
    git checkout $BRANCH_NAME
else
    git checkout -B $BRANCH_NAME
fi

rm -rf $DIR && mkdir -p $DIR && cp -frpT /workspace $DIR
find $DIR -type d -name ".io" -or -name ".git" \
-or -name "home" -exec rm -rf {} \;
find $DIR -type f -name "update.sh" -or -name "README.md" \
-or -name "steps.csv" -exec rm -rfv {} \;
find $DIR -type f -name "*.sh" -and ! -name "account.sh" \
-and ! -name "artifact.sh" -exec echo {} \;

echo "\n$hr\nPUSH\n$hr"
sed -i "s/-[0-9]\{1,\}-\([a-zA-Z0-9_]*\)'/-`date +%d%H%M`-cron'/g" cloudbuild.yaml
git status && git add . && git commit -m "sync source"
git push origin $BRANCH_NAME

eval `ssh-agent -k`
