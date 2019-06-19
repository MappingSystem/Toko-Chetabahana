#!/bin/bash
: <<'END'
$ mv --help
Usage: mv [OPTION]... [-T] SOURCE DEST
  or:  mv [OPTION]... SOURCE... DIRECTORY
  or:  mv [OPTION]... -t DIRECTORY SOURCE...
Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.
      --backup[=CONTROL]       make a backup of each existing destination file
  -b                           like --backup but does not accept an argument
  -f, --force                  do not prompt before overwriting
  -i, --interactive            prompt before overwrite
  -n, --no-clobber             do not overwrite an existing file
If you specify more than one of -i, -f, -n, only the final one takes effect.
      --strip-trailing-slashes  remove any trailing slashes from each SOURCE
                                 argument
  -S, --suffix=SUFFIX          override the usual backup suffix
  -t, --target-directory=DIRECTORY  move all SOURCE arguments into DIRECTORY
  -T, --no-target-directory    treat DEST as a normal file
  -u, --update                 move only when the SOURCE file is newer
                                 than the destination file or when the
                                 destination file is missing
  -v, --verbose                explain what is being done
  -Z, --context                set SELinux security context of destination
                                 file to default type
      --help     display this help and exit
      --version  output version information and exit

The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the --backup option or through
the VERSION_CONTROL environment variable.  Here are the values:

  none, off       never make backups (even if --backup is given)
  numbered, t     make numbered backups
  existing, nil   numbered if numbered backups exist, simple otherwise
  simple, never   always make simple backups

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Report mv translation bugs to <http://translationproject.org/team/>
Full documentation at: <http://www.gnu.org/software/coreutils/mv>
or available locally via: info '(coreutils) mv invocation'
END

cd $HOME
apt-get update
apt-get --assume-yes install expect
apt-get --assume-yes install transifex-client
rm -rf saleor && git clone https://github.com/mirumee/saleor.git

cd /workspace/scripts && chmod -R +x *
find . -type f -name '*.sh' | sort | sh > branches.log
cat /workspace/scripts/branches.log

AGENT=/root/.ssh/agent_builder
cd $HOME && rm -rf Toko-Chetabahana
git config --global user.name "chetabahana"
git config --global user.email "chetabahana@gmail.com"
eval `ssh-agent` && expect $AGENT && ssh-add -l
git clone git@github.com:MarketLeader/Toko-Chetabahana.git
mv -f /workspace/scripts/branches.log Toko-Chetabahana/logs/
cd Toko-Chetabahana && git add . && git commit -m "fresh commit"
git push -u origin master
eval `ssh-agent -k`

mv -f /workspace/windows/cygwin/home/Chetabahana/.ssh $HOME
chmod 0400 $HOME/.ssh/*
