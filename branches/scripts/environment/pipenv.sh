#!/bin/sh

: <<'END'
$ pipenv
Usage: pipenv [OPTIONS] COMMAND [ARGS]...

Options:
  --where          Output project home information.
  --venv           Output virtualenv information.
  --py             Output Python interpreter information.
  --envs           Output Environment Variable options.
  --rm             Remove the virtualenv.
  --bare           Minimal output.
  --completion     Output completion (to be eval).
  --man            Display manpage.
  --three / --two  Use Python 3/2 when creating virtualenv.
  --python TEXT    Specify which version of Python virtualenv should use.
  --site-packages  Enable site-packages for the virtualenv.
  --version        Show the version and exit.
  -h, --help       Show this message and exit.


Usage Examples:
   Create a new project using Python 3.7, specifically:
   $ pipenv --python 3.7

   Remove project virtualenv (inferred from current directory):
   $ pipenv --rm

   Install all dependencies for a project (including dev):
   $ pipenv install --dev

   Create a lockfile containing pre-releases:
   $ pipenv lock --pre

   Show a graph of your installed dependencies:
   $ pipenv graph

   Check your installed dependencies for security vulnerabilities:
   $ pipenv check

   Install a local setup.py into your virtual environment/Pipfile:
   $ pipenv install -e .

   Use a lower-level pip command:
   $ pipenv run pip freeze

Commands:
  check      Checks for security vulnerabilities and against PEP 508 markers
             provided in Pipfile.
  clean      Uninstalls all packages not specified in Pipfile.lock.
  graph      Displays currently–installed dependency graph information.
  install    Installs provided packages and adds them to Pipfile, or (if no
             packages are given), installs all packages from Pipfile.
  lock       Generates Pipfile.lock.
  open       View a given module in your editor.
  run        Spawns a command installed into the virtualenv.
  shell      Spawns a shell within the virtualenv.
  sync       Installs all packages specified in Pipfile.lock.
  uninstall  Un-installs a provided package and removes it from Pipfile.
END

#Package
#APP="install gunicorn gevent"
GIT=https://github.com/mirumee/saleor.git

#Environment
export PATH=$HOME/.local/bin:$PATH

echo "\nPIPENV\n"
pip install --user pipenv

echo "\nPACKAGES\n"
cd $HOME && rm -rf saleor
git clone $GIT && cd $HOME/saleor

pipenv sync
[ -n "$APP" ] && pipenv $APP

echo "\nGRAPH\n"
pipenv clean
pipenv graph

echo "\nTRANSFER\n"
pipenv lock -r > requirements.txt
pipenv lock -r -d > requirements_dev.txt
BRANCH=/workspace/home/chetabahana/.docker/branch
cp -fv Pipfile Pipfile.lock requirements.txt requirements_dev.txt -t $BRANCH

echo "\nPIPLOCK\n"
cat requirements.txt

echo "\nDEV PACKAGES\n"
pipenv install --dev

echo "\nTOX RESULT\n"
pipenv run tox

echo "\nCHECK RESULT\n"
pipenv check
