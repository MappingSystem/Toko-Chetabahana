#!/bin/sh

: <<'END'
$ docker cp --help
Copy files/folders between a container and the local filesystem
Usage:  docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
        docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH
Options:
  -a, --archive       Archive mode (copy all uid/gid information)
  -L, --follow-link   Always follow symbol link in SRC_PATH
END

eval `ssh-agent -k` && eval `ssh-agent` && expect ~/.ssh/agent && ssh-add -l

echo "\nDEFAULT\n"
cd ~/.docker/compose && rm -rf default
git clone git@github.com:Chetabahana/default.git
rm -rf default/media default/static && cp -frpT /tmp/volume default

cd default
sed -i 's/-local/-fresh/g' cloudbuild.yaml
git status && git add . && git commit -m "fresh commit" && git push -u origin master
cd .. && rm -rf default

echo "\nMARKET\n"
cd ~/.docker/compose && rm -rf market
git clone git@github.com:Chetabahana/market.git
rm -rf market/media market/static && cp -frpT /tmp/volume market
docker cp compose_celery_1:/app . && cp -frpT app market
cp -frpvT deploy/market market && rm -rf app

cd market
sed -i "s|'America/Chicago'|'Asia/Jakarta'|g" saleor/settings.py
sed -i "s|LANGUAGE_CODE = 'en'|LANGUAGE_CODE = 'id'|g" saleor/settings.py
git status && git add . && git commit -m "gunicorn" && git push -u origin master
cd .. && rm -rf market

return
