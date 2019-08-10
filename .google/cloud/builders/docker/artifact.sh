#!/bin/sh

echo "\n$hr\nCURRENT OUTPUT\n$hr"
OUTPUT_REPO=Toko-Chetabahana
cd $BUILDER_OUTPUT/volume/$OUTPUT_REPO
ls -al .

echo "\n$hr\nPUSH OUTPUT\n$hr"
bash $HOME/.ssh/push
