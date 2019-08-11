#!/bin/sh
[ -z "${OUTPUT_REPO}" ] && return

echo "\n$hr\nENVIRONTMENT\n$hr"
HR=$hr && unset hr
HRD=$hrd && unset hrd
printenv | sort
export hr=$HR
export hrd=$HRD

echo "\n$hr\nCURRENT OUTPUT\n$hr"
cd $OUTPUTS_VOLUME/$OUTPUT_REPO
cp -f /workspace/.io/cloudbuild.yaml .
ls -al .

echo "\n$hr\nPUSH OUTPUT\n$hr"
bash $HOME/.ssh/push
