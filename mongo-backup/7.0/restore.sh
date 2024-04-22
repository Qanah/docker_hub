#!/bin/bash

# Fetch a (gzipped) backup file from S3.
# Restore it.

. /etc/container_environment.sh

# Bailout if any command fails
set -e

# Specify mongo host (mongo by default)
MONGO_HOST=${MONGO_HOST:-mongo}
MONGODUMP_OPTIONS=${MONGODUMP_OPTIONS:-"--authenticationDatabase=admin"}

# Check that a backup is specified or list all backups!
if [ -z "$1" ]
then
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY --region=$REGION ls $BUCKET
else
	# Create a temporary directory to hold the backup files
	DIR=$(mktemp -d)

	# Get the backups from S3
	s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY --region=$REGION get $BUCKET$1 $DIR/$1

	# Restore the DB
    mongorestore --host $MONGO_HOST --username $MONGO_ROOT_USERNAME --password $MONGO_ROOT_PASSWORD $MONGODUMP_OPTIONS --gzip --archive=$DIR/$1

	# Clean up
	rm -rf $DIR
fi
