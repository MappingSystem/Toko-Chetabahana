#!/bin/sh

: <<'END'
$ docker-compose down --help
Stops containers and removes containers, networks, volumes, and images
created by `up`.

By default, the only things removed are:

- Containers for services defined in the Compose file
- Networks defined in the `networks` section of the Compose file
- The default network, if one is used

Networks and volumes defined as `external` are never removed.

Usage: down [options]

Options:
    --rmi type              Remove images. Type must be one of:
                              'all': Remove all images used by any service.
                              'local': Remove only images that don't have a
                              custom tag set by the `image` field.
    -v, --volumes           Remove named volumes declared in the `volumes`
                            section of the Compose file and anonymous volumes
                            attached to containers.
    --remove-orphans        Remove containers for services not defined in the
                            Compose file
    -t, --timeout TIMEOUT   Specify a shutdown timeout in seconds.
                            (default: 10)
END

export hr=${1}
export BRANCH=${2}
export INSTANCE==${3}

echo "\n$hr\nDISK\n$hr"
df -h

echo "\n$hr\nACTIVE\n$hr"
netstat -nlt

echo "\n$hr\nPULL\n$hr"
IMAGE=NEW
for i in redis registry postgres chetabahana/saleor; do
if grep -Fqe "Image is up to date" << EOF
`docker pull $i`
EOF
then
   echo "image is uptodate: $i"
else
   IMAGE=OLD
   echo "image is outdated: $i"
fi
done

if [ "${IMAGE}" = "NEW" ] && [ "${BRANCH}" = "master" ]
then
   echo "all images are new, do nothing"
else
   echo "\n$hr\nUPDATE\n$hr"
   cd ~/.docker/compose
   CURRENT_UID=$(id -u):$(id -g) docker-compose down -v
   echo "$hr\nMIGRATE\n$hr"
   CURRENT_UID=$(id -u):$(id -g) docker-compose up -d postgres
   CURRENT_UID=$(id -u):$(id -g) docker-compose up -d celery
   sh ~/.docker/deploy/gae.sh $hr
   gcloud compute instances add-metadata backend --metadata enable-migrate=true
fi

echo "\n$hr\nIMAGES\n$hr"
echo "Cleaning.." && docker system prune --force && echo "\n$hr\n"
docker images --all

echo "\n$hr\nDAEMON\n$hr"
sudo netstat -lntp | grep dockerd

echo "\n$hr\nSERVICES\n$hr"
docker ps

echo "\n$hr\nCONFIG\n$hr"
cd ~/.docker/compose
docker-compose config
docker-compose --version

echo "\n$hr\nREDIS\n$hr"
docker inspect compose_redis_1

echo "\n$hr\nPOSTGRES\n$hr"
docker inspect compose_postgres_1

echo "\n$hr\nCELERY\n$hr"
docker inspect compose_celery_1

echo "\n$hr\nLOGS\n$hr"
docker-compose logs

#(sleep 5; sudo reboot) &
