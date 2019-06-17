#!/bin/bash
if [ $HOME == "/builder/home" ]
then 
    mv -f /workspace/windows/cygwin/home/Chetabahana/.ssh $HOME
    chmod 0400 $HOME/.ssh/*
else
    cd ~/.docker/compose/scripts && chmod -R +x *
    find . -type f -name '*.sh' | sort | sh > compose.log
    mv -f compose.log ~/.logs/ && cat ~/.logs/compose.log
fi
