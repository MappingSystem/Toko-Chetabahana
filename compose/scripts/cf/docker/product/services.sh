#!/bin/sh

: <<'END'
$ docker logs --help

Usage:  docker logs [OPTIONS] CONTAINER

Fetch the logs of a container

Options:
      --details        Show extra details provided to logs
  -f, --follow         Follow log output
      --since string   Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
      --tail string    Number of lines to show from the end of the logs (default "all")
  -t, --timestamps     Show timestamps
      --until string   Show logs before a timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)

$ docker-compose logs --help
View output from containers.

Usage: logs [options] [SERVICE...]

Options:
    --no-color          Produce monochrome output.
    -f, --follow        Follow log output.
    -t, --timestamps    Show timestamps.
    --tail="all"        Number of lines to show from the end of the logs
                        for each container.
END

echo "\nREDIS\n"
docker inspect compose_redis_1
docker logs compose_redis_1

echo "\nPOSTGRES\n"
docker inspect compose_postgres_1
docker logs compose_postgres_1

echo "\nCELERY\n"
docker inspect compose_celery_1
docker logs compose_celery_1

echo "\nSALEOR\n"
docker inspect compose_saleor_1
docker logs compose_saleor_1

echo "\nSERVICES\n"
docker ps

echo "\nBUNDLE\n"
cd $WORKSPACE/compose/home/chetabahana/.docker/compose
CURRENT_UID=$(id -u):$(id -g) docker-compose bundle --output compose.dab

echo "\nDETAILS\n"
cat compose.dab

