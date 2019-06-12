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
export NEXT=taxonomy
export CURRENT=gunicorn

echo "\nAGENT\n"
eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l

echo "\nBRANCHES\n"
cd /home/chetabahana/.docker/compose
[ -d Toko-Chetabahana ] && rm -rf Toko-Chetabahana|| echo "cloning.."
git clone git@github.com:MarketLeader/Toko-Chetabahana.git
cp -frpT ~/.logs Toko-Chetabahana/logs && cd Toko-Chetabahana
git add . && git commit -m "fresh commit"
git push -u origin master

echo "\nUPSTREAM\n"
cd /home/chetabahana/.docker/compose
[ -d Tutorial-Buka-Toko ] && rm -rf Tutorial-Buka-Toko || echo "cloning.."
git clone git@github.com:MarketLeader/Tutorial-Buka-Toko.git
cd Tutorial-Buka-Toko && git checkout master
git remote add upstream git@github.com:mirumee/saleor.git
git pull --rebase upstream master && git reset --hard upstream/master
git push origin master --force

echo "\nREMOTE\n"
git checkout Chetabahana
git fetch --prune origin && git reset --hard origin/master
cp -frpvT ~/.docker/branch ~/.docker/compose/Tutorial-Buka-Toko
git status && git add . && git commit -m "Add support for ${NEXT}"
git push origin Chetabahana --force

echo "\nMASTER\n"
cd /home/chetabahana/.docker/compose
[ -d saleor ] && rm -rf saleor || echo "cloning.."
git clone git@github.com:Chetabahana/saleor.git saleor && cd saleor
git remote add upstream git@github.com:MarketLeader/Tutorial-Buka-Toko.git
git fetch --prune upstream Chetabahana && git reset --hard upstream/Chetabahana
git push origin master --force

#echo "\nCURRENT\n"
#git checkout "${CURRENT}"
#git fetch --prune origin master && git reset --hard origin/master
#git push origin "${CURRENT}" --force

echo "\nNEXT\n"
git checkout "${NEXT}"
git fetch --prune origin master && git reset --hard origin/master
tx pull --all > /dev/null
find saleor -type f -print0 | xargs -0 sed -i 's|"localhost:8000"|"www.chetabahana.com"|g'
git push origin "${NEXT}" --force

cd /home/chetabahana/.docker/compose
rm -rf saleor Toko-Chetabahana Tutorial-Buka-Toko
eval `ssh-agent -k`
