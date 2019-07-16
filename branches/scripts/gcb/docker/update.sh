#!/bin/sh

: <<'END'
$ git --help
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with G

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
END

cd $HOME

#Environtment
USER=chetabahana
SHOP=Toko-Chetabahana
ORGANIZATION=MarketLeader

echo "\nSYNC\n"
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
