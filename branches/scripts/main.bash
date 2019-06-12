#!/bin/bash
: <<'END'
END

git clone https://github.com/mirumee/saleor.git 
cd /workspace/saleor && ls -al

cd /workspace/scripts && chmod -R +x *
find . -type f -name '*.sh' | sort | sh > branches.log
mv /workspace/scripts/branches.log /workspace/home/chetabahana/.logs/
cat /workspace/home/chetabahana/.logs/branches.log
