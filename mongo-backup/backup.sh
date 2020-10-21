#!/bin/bash

# Generate a (gzipped) dumpfile for each database specified in ${DBS}.
# Upload to S3.

. /etc/container_environment.sh

# Bailout if any command fails
set -e

# Specify mongo host (mongo by default)
MONGO_HOST=${MONGO_HOST:-mongo}
MONGODUMP_OPTIONS=${MONGODUMP_OPTIONS:-"--authenticationDatabase=admin"}

# Create a temporary directory to hold the backup files.
DIR=$(mktemp -d)

# Generate a timestamp to name the backup files with.
TS=$(date +%s)

# Backup all databases, unless a list of databases has been specified
if [ -z "$DBS" ]
then
	# Backup all DB's in bulk
	mongodump --host $MONGO_HOST --username $MONGO_ROOT_USERNAME --password $MONGO_ROOT_PASSWORD $MONGODUMP_OPTIONS --gzip --archive > $DIR/all-databases-$TS.db.gz
else
	# Backup each DB separately
	for DB in $DBS
	do
		mongodump --host $MONGO_HOST --username $MONGO_ROOT_USERNAME --password $MONGO_ROOT_PASSWORD $MONGODUMP_OPTIONS --db $DB --gzip --archive > $DIR/$DB-$TS.db.gz
	done
fi

# Upload the backups to S3 --region=$REGION
s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY --region=$REGION sync $DIR/ $BUCKET

# Clean up
rm -rf $DIR
