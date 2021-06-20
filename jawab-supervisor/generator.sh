#!/bin/bash

echo "Running docker-compose build"
docker-compose build --no-cache
echo "Finished docker-compose build"

echo "Running docker-compose push"
docker-compose push
echo "Finished docker-compose push"
