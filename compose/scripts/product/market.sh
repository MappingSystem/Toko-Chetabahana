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

echo "\nDEFAULT\n"
cd ~/.docker/compose && rm -rf default
git clone git@github.com:cetabahana/default.git
rm -rf default/media default/static && cp -frpT /tmp/volume default

cd default
sed -i 's/-local/-fresh/g' cloudbuild.yaml
git status && git add . && git commit -m "fresh commit" && git push -u origin master
cd .. && rm -rf default

echo "\nPRODUCT\n"
cd ~/.docker/compose && rm -rf product
git clone git@github.com:chetabahana/product.git
rm -rf product/media product/static && cp -frpT /tmp/volume product
docker cp compose_celery_1:/app . && cp -frpT app product
cp -frpvT deploy/product product && rm -rf app

cd product
sed -i "s|'America/Chicago'|'Asia/Jakarta'|g" saleor/settings.py
sed -i "s|LANGUAGE_CODE = 'en'|LANGUAGE_CODE = 'id'|g" saleor/settings.py
git status && git add . && git commit -m "gunicorn" && git push -u origin master
cd .. && rm -rf product

return
