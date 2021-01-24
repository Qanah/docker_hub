#!/bin/bash

echo "Running docker-compose build"
# docker-compose build --no-cache
docker-compose build
echo "Finished docker-compose build"

echo "Running docker-compose push"
docker-compose push
echo "Finished docker-compose push"
