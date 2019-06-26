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

docker ps

echo "\nDOWN\n"
if [ -d ~/.docker/compose ]; then
   cd ~/.docker/compose
   docker-compose --version
   docker-compose down --volumes
fi

echo "\nGIT\n"
cd ~/.docker
sudo rm -rf branches compose
eval `ssh-agent` && expect ~/.ssh/agent
git clone git@github.com:Chetabahana/compose.git
git clone git@github.com:Chetabahana/branches.git
eval `ssh-agent -k`

cd ~/.docker/compose && git checkout ${1}
cd ~/.docker/branches && git checkout ${1}
mv -fv ~/.docker/branches/home ~/.docker/compose
sudo rm -rf ~/.docker/branches

echo "\nUP\n"
cd ~/.docker/compose
docker-compose --version

echo "\n"
docker-compose config
CURRENT_UID=$(id -u):$(id -g) docker-compose up -d

echo "\nSERVICES\n"
docker ps

echo "\nREDIS\n"
docker logs compose_redis_1
docker inspect compose_redis_1

echo "\nPOSTGRES\n"
docker logs compose_postgres_1
docker inspect compose_postgres_1

echo "\nCELERY\n"
docker logs compose_celery_1
docker inspect compose_celery_1

echo "\nLOGS\n"
docker-compose logs

(sleep 5; sudo reboot) &
