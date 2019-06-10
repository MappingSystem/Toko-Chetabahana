#!/bin/sh
: <<'END'
END

./info.sh
./run.sh
./gs.sh
#./git.sh
#./curl.sh
./market.sh
./services.sh

(sleep 3; sudo reboot) &
