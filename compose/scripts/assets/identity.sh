#!/bin/sh
: <<'END'
END

echo "\nWHOAMI\n"
whoami
pwd
id

echo "\nDISK\n"
df -h

echo "\nNET STATUS\n"
sudo netstat -plnt

echo "\nNMAP STATUS"
nmap scanme.nmap.org
