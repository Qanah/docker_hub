#!/bin/bash

#Author: Ibrahim Qanah

#Convenience script that can help me to easily create a clone of a given
#data volume. The script is mainly useful if you are using named volumes


#First check if the user provided all needed arguments
if [ "$1" = "" ]
then
        echo "Please provide a source volume name"
        exit
fi

if [ "$2" = "" ]
then
        echo "Please provide ssh credentials"
        exit
fi

if [ "$3" = "" ]
then
        echo "Please provide a destination volume name"
        exit
fi


#Check if the source volume name does exist
docker volume inspect $1 > /dev/null 2>&1
if [ "$?" != "0" ]
then
        echo "The source volume \"$1\" does not exist"
        exit
fi

docker run --rm \
           -v $1:/from alpine ash -c "cd /from ; tar -cf - . " | \
           ssh $2 "docker run --rm -i -v $3:/to alpine ash -c 'cd /to ; tar -xpvf - '"

