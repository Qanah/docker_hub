#!/bin/bash

volume=''
command='find'

print_usage() {
  echo " "
  echo "docker volume busybox [options]"
  echo " "
  echo "-h --help     show brief help"
  echo "-v            specify an volume name"
  echo "-c            specify an command default \"find\""
  echo " "
}

while getopts v:c: flag; do
  case "${flag}" in
    v) volume=${OPTARG};;
    c) command="${OPTARG}";;
    *) print_usage
       exit 1 ;;
  esac
done

if [ "$volume" = "" ]
then
    echo "Please provide a source volume name"
    exit
fi

#Check if the source volume name does exist
docker volume inspect $volume > /dev/null 2>&1
if [ "$?" != "0" ]
then
    echo "The source volume \"$volume\" does not exist"
    exit
fi

docker run --rm -i -v=$volume:/tmp busybox $command /tmp
