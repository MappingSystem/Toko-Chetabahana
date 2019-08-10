#!/bin/sh

OUTPUT_REPO=Toko-Chetabahana
git clone https://github.com/MarketLeader/$OUTPUT_REPO.git $BUILDER_OUTPUT/volume/$OUTPUT_REPO
find .io -type d -name $OUTPUT_REPO -exec cp -fv {}/README.md . \;
cp -frpT /workspace $BUILDER_OUTPUT/volume/$OUTPUT_REPO

echo "\n$hr\nCURRENT OUTPUT\n$hr"
ls -al $BUILDER_OUTPUT/volume/$OUTPUT_REPO
