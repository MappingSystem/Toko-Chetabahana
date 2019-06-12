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
END

echo "\nSERVICES\n"
docker ps

echo "\nREDIS\n"
docker logs compose_redis_1

echo "\nPOSTGRES\n"
docker logs compose_postgres_1

echo "\nCELERY\n"
docker logs compose_celery_1

echo "\nLOGS\n"
docker-compose logs
