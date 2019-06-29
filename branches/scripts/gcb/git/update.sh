#!/bin/sh

: <<'END'
$ git -h
unknown option: -h
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

$ git remote -h
usage: git remote [-v | --verbose]
   or: git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>
   or: git remote rename <old> <new>
   or: git remote remove <name>
   or: git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
   or: git remote [-v | --verbose] show [-n] <name>
   or: git remote prune [-n | --dry-run] <name>
   or: git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]
   or: git remote set-branches [--add] <name> <branch>...
   or: git remote get-url [--push] [--all] <name>
   or: git remote set-url [--push] <name> <newurl> [<oldurl>]
   or: git remote set-url --add <name> <newurl>
   or: git remote set-url --delete <name> <url>

    -v, --verbose         be verbose; must be placed before a subcommand

$ git clone -h
usage: git clone [<options>] [--] <repo> [<dir>]

    -v, --verbose         be more verbose
    -q, --quiet           be more quiet
    --progress            force progress reporting
    -n, --no-checkout     don't create a checkout
    --bare                create a bare repository
    --mirror              create a mirror repository (implies bare)
    -l, --local           to clone from a local repository
    --no-hardlinks        don't use local hardlinks, always copy
    -s, --shared          setup as shared repository
    --recurse-submodules[=<pathspec>]
                          initialize submodules in the clone
    -j, --jobs <n>        number of submodules cloned in parallel
    --template <template-directory>
                          directory from which templates will be used
    --reference <repo>    reference repository
    --reference-if-able <repo>
                          reference repository
    --dissociate          use --reference only while cloning
    -o, --origin <name>   use <name> instead of 'origin' to track upstream
    -b, --branch <branch>
                          checkout <branch> instead of the remote's HEAD
    -u, --upload-pack <path>
                          path to git-upload-pack on the remote
    --depth <depth>       create a shallow clone of that depth
    --shallow-since <time>
                          create a shallow clone since a specific time
    --shallow-exclude <revision>
                          deepen history of shallow clone, excluding rev
    --single-branch       clone only one branch, HEAD or --branch
    --no-tags             don't clone any tags, and make later fetches not to follow them
    --shallow-submodules  any cloned submodules will be shallow
    --separate-git-dir <gitdir>
                          separate git dir from working tree
    -c, --config <key=value>
                          set config inside the new repository
    -4, --ipv4            use IPv4 addresses only
    -6, --ipv6            use IPv6 addresses only
    --filter <args>       object filtering
END

#Environtment
NEXT=taxonomy
CURRENT=gunicorn
	
echo "\nAGENT\n"
eval `ssh-agent`
apt-get update > /dev/null
apt-get install -y --no-install-recommends apt-utils > /dev/null
apt-get --assume-yes install expect > /dev/null
git config --global user.name "chetabahana"
git config --global user.email "chetabahana@gmail.com"
ln -s $HOME/.ssh /root/.ssh && expect /root/.ssh/agent > /dev/null && ssh-add -l

echo "\nSYNCHING\n"
REPO='github_'$PROJECT_ID'_compose'
cd $HOME && rm -rf compose Toko-Chetabahana
git clone git@github.com:MarketLeader/Toko-Chetabahana.git
git clone https://source.developers.google.com/p/$PROJECT_ID/r/$REPO compose
rm -rf $HOME/Toko-Chetabahana/branches $HOME/Toko-Chetabahana/compose
cp -frpT /workspace $HOME/Toko-Chetabahana/branches
cp -frpT $HOME/compose $HOME/Toko-Chetabahana/compose
cd $HOME/Toko-Chetabahana/branches && rm -rf .git home
cd $HOME/Toko-Chetabahana/compose && rm -rf .git home
cd $HOME/Toko-Chetabahana && git status 
git add . && git commit -m "sync source"
git push -u origin master

echo "\nUPSTREAM\n"
cd $HOME && rm -rf Tutorial-Buka-Toko
git clone git@github.com:MarketLeader/Tutorial-Buka-Toko.git
cd Tutorial-Buka-Toko && git checkout master
git remote add upstream git@github.com:mirumee/saleor.git
git pull --rebase upstream master && git reset --hard upstream/master
git push origin master --force

echo "\nREMOTE\n"
git checkout Chetabahana
BRANCH=$BUILD_DIR/$PROJECT_ID/.docker/branch
git fetch --prune origin && git reset --hard origin/master
cp -frpvT $BRANCH "$HOME/Tutorial-Buka-Toko"
git status && git add . && git commit -m "Add support for ${NEXT}"
git push origin Chetabahana --force

echo "\nMASTER\n"
cd $HOME && rm -rf saleor
git clone git@github.com:Chetabahana/saleor.git saleor && cd saleor
git remote add upstream git@github.com:MarketLeader/Tutorial-Buka-Toko.git
git fetch --prune upstream Chetabahana && git reset --hard upstream/Chetabahana
git push origin master --force

#echo "\nCURRENT\n"
#git checkout "${CURRENT}"
#git fetch --prune origin master && git reset --hard origin/master
#git status && git add . && git commit -m "Add support for ${CURRENT}"
#git push origin "${CURRENT}" --force

echo "\nNEXT\n"
git checkout "${NEXT}"
git fetch --prune origin master && git reset --hard origin/master
export PATH=$HOME/.local/bin:$PATH && pipenv run tx pull --all > /dev/null
find saleor -type f -print0 | xargs -0 sed -i 's|"localhost:8000"|"www.chetabahana.com"|g'
git status && git add . && git commit -m "Add support for ${NEXT}"
#git push origin "${NEXT}" --force

cd $HOME
rm -rf compose saleor Tutorial-Buka-Toko Toko-Chetabahana
eval `ssh-agent -k`
