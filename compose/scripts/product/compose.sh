#!/bin/sh

: <<'END'
$ docker-compose version
docker-compose version 1.23.2, build 1110ad01
docker-py version: 3.6.0
CPython version: 3.6.7
OpenSSL version: OpenSSL 1.1.0f  25 May 2017


$ docker-compose --help
Define and run multi-container applications with Docker.

Usage:
  docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]
  docker-compose -h|--help

Options:
  -f, --file FILE             Specify an alternate compose file
                              (default: docker-compose.yml)
  -p, --project-name NAME     Specify an alternate project name
                              (default: directory name)
  --verbose                   Show more output
  --log-level LEVEL           Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
  --no-ansi                   Do not print ANSI control characters
  -v, --version               Print version and exit
  -H, --host HOST             Daemon socket to connect to

  --tls                       Use TLS; implied by --tlsverify
  --tlscacert CA_PATH         Trust certs signed only by this CA
  --tlscert CLIENT_CERT_PATH  Path to TLS certificate file
  --tlskey TLS_KEY_PATH       Path to TLS key file
  --tlsverify                 Use TLS and verify the remote
  --skip-hostname-check       Don't check the daemon's hostname against the
                              name specified in the client certificate
  --project-directory PATH    Specify an alternate working directory
                              (default: the path of the Compose file)
  --compatibility             If set, Compose will attempt to convert deploy
                              keys in v3 files to their non-Swarm equivalent

Commands:
  build              Build or rebuild services
  bundle             Generate a Docker bundle from the Compose file
  config             Validate and view the Compose file
  create             Create services
  down               Stop and remove containers, networks, images, and volumes
  events             Receive real time events from containers
  exec               Execute a command in a running container
  help               Get help on a command
  images             List images
  kill               Kill containers
  logs               View output from containers
  pause              Pause services
  port               Print the public port for a port binding
  ps                 List containers
  pull               Pull service images
  push               Push service images
  restart            Restart services
  rm                 Remove stopped containers
  run                Run a one-off command
  scale              Set number of containers for a service
  start              Start services
  stop               Stop services
  top                Display the running processes
  unpause            Unpause services
  up                 Create and start containers
  version            Show the Docker-Compose version information

$ docker-compose run --help
Run a one-off command on a service.

For example:

    $ docker-compose run web python manage.py shell

By default, linked services will be started, unless they are already
running. If you do not want to start linked services, use
`docker-compose run --no-deps SERVICE COMMAND [ARGS...]`.

Usage:
    run [options] [-v VOLUME...] [-p PORT...] [-e KEY=VAL...] [-l KEY=VALUE...]
        SERVICE [COMMAND] [ARGS...]

Options:
    -d, --detach          Detached mode: Run container in the background, print
                          new container name.
    --name NAME           Assign a name to the container
    --entrypoint CMD      Override the entrypoint of the image.
    -e KEY=VAL            Set an environment variable (can be used multiple times)
    -l, --label KEY=VAL   Add or override a label (can be used multiple times)
    -u, --user=""         Run as specified username or uid
    --no-deps             Don't start linked services.
    --rm                  Remove container after run. Ignored in detached mode.
    -p, --publish=[]      Publish a container's port(s) to the host
    --service-ports       Run command with the service's ports enabled and mapped
                          to the host.
    --use-aliases         Use the service's network aliases in the network(s) the
                          container connects to.
    -v, --volume=[]       Bind mount a volume (default [])
    -T                    Disable pseudo-tty allocation. By default `docker-compose run`
                          allocates a TTY.
    -w, --workdir=""      Working directory inside the container


$ docker-compose up --help
Builds, (re)creates, starts, and attaches to containers for a service.

Unless they are already running, this command also starts any linked services.

The `docker-compose up` command aggregates the output of each container. When
the command exits, all containers are stopped. Running `docker-compose up -d`
starts the containers in the background and leaves them running.

If there are existing containers for a service, and the service's configuration
or image was changed after the container's creation, `docker-compose up` picks
up the changes by stopping and recreating the containers (preserving mounted
volumes). To prevent Compose from picking up changes, use the `--no-recreate`
flag.

If you want to force Compose to stop and recreate all containers, use the
`--force-recreate` flag.

Usage: up [options] [--scale SERVICE=NUM...] [SERVICE...]

Options:
    -d, --detach               Detached mode: Run containers in the background,
                               print new container names. Incompatible with
                               --abort-on-container-exit.
    --no-color                 Produce monochrome output.
    --quiet-pull               Pull without printing progress information
    --no-deps                  Don't start linked services.
    --force-recreate           Recreate containers even if their configuration
                               and image haven't changed.
    --always-recreate-deps     Recreate dependent containers.
                               Incompatible with --no-recreate.
    --no-recreate              If containers already exist, don't recreate
                               them. Incompatible with --force-recreate and -V.
    --no-build                 Don't build an image, even if it's missing.
    --no-start                 Don't start the services after creating them.
    --build                    Build images before starting containers.
    --abort-on-container-exit  Stops all containers if any container was
                               stopped. Incompatible with -d.
    -t, --timeout TIMEOUT      Use this timeout in seconds for container
                               shutdown when attached or when containers are
                               already running. (default: 10)
    -V, --renew-anon-volumes   Recreate anonymous volumes instead of retrieving
                               data from the previous containers.
    --remove-orphans           Remove containers for services not defined
                               in the Compose file.
    --exit-code-from SERVICE   Return the exit code of the selected service
                               container. Implies --abort-on-container-exit.
    --scale SERVICE=NUM        Scale SERVICE to NUM instances. Overrides the
                               `scale` setting in the Compose file if present.
							   
Usage for Saleor Development, Running Test & Translations:
https://docs.getsaleor.com/en/latest/customization/docker.html
https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15
END


echo "\nCLEANING\n"
#sudo rm -rfv /tmp/volume
mkdir -pv /tmp/volume/static
chmod -R a+rw /tmp/volume

#echo "\nPULLING\n"
#docker pull redis
#docker pull postgres
#docker pull chetabahana/saleor
#docker pull chetabahana/celery

#echo "\nCLAIMING\n"
#docker system prune --force

#echo "\nIMAGES\n"
#docker images --all

echo "\nCONFIG\n"
#cd /home/chetabahana/.docker/compose
RELEASE="https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)"
curl -s -L $RELEASE -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
docker-compose config

echo "\nREDIS\n"
CURRENT_UID=$(id -u):$(id -g) docker-compose up -d redis
docker inspect workspace_redis_1

echo "\nPOSTGRES\n"
CURRENT_UID=$(id -u):$(id -g) docker-compose up -d postgres
docker inspect workspace_postgres_1

echo "\nMIGRATE\n"
docker-compose run --rm --user $(id -u):$(id -g) saleor python3 manage.py migrate --verbosity 3

echo "\nSTATIC\n"
docker-compose run --rm --user $(id -u):$(id -g) saleor python3 manage.py collectstatic --noinput --clear --verbosity 3

echo "\nPOPULATE\n"
docker-compose run --rm --user $(id -u):$(id -g) saleor python3 manage.py populatedb --createsuperuser --verbosity 3
  
#echo "\nMEDIA\n"
#docker-compose run --rm --user $(id -u):$(id -g) saleor python3 manage.py create_thumbnails --verbosity 3

echo "\nCELERY\n"
CURRENT_UID=$(id -u):$(id -g) docker-compose up -d celery
docker inspect workspace_celery_1
sleep 10
