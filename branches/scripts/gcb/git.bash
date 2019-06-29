#!/bin/bash

: <<'END'
$ export --help
export: export [-fn] [name[=value] ...] or export -p
    Set export attribute for shell variables.
    
    Marks each NAME for automatic export to the environment of subsequently
    executed commands.  If VALUE is supplied, assign VALUE before exporting.
    
    Options:
      -f        refer to shell functions
      -n        remove the export property from each NAME
      -p        display a list of all exported variables and functions
    
    An argument of `--' disables further option processing.
    
    Exit Status:
    Returns success unless an invalid option is given or NAME is invalid.
END

export PROJECT_ID=${1}
export REPO_NAME=${2}
export BRANCH_NAME=${3}
export BUILD_ID=${4}
export COMMIT_SHA=${5}
export BUILD_DIR=${6}
export USER_NAME=${7}
export USER_EMAIL=${8}
export USER_REPO=${9}

export DIRNAME=$(dirname "$0")
export BASENAME=$(basename "$0" .bash)
export BASEFILE=$(basename "$DIRNAME").bash
cd $DIRNAME && bash ../$BASEFILE $DIRNAME/$BASENAME
