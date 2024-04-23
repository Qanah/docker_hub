#!/bin/bash
set -e
trap 'catch $? $LINENO' EXIT
catch() {
 echo "catching!"
 if [ "$1" != "0" ]; then
   # error handling goes here
   echo "Error $1 occurred on $2"
 fi
}

echo "Running docker-compose build"
docker compose build --no-cache
echo "Finished docker-compose build"

echo "Running docker-compose push"
docker compose push
echo "Finished docker-compose push"
