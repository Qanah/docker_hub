FROM nickbreen/cron:v1.0.0

# Update package lists and install required packages
RUN apt-get -qqy update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2-utils python3-pip && \
    apt-get -qqy clean

# Install s3cmd using pip3
RUN pip3 install s3cmd

# Add mongodb org official apt source to the sources list
ENV GPG_KEYS 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN set -ex; \
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $GPG_KEYS; do \
		gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "$key"; \
	done; \
	gpg --batch --export $GPG_KEYS > /etc/apt/trusted.gpg.d/mongodb.gpg; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -r "$GNUPGHOME"; \
    apt-key list

RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Install MongoDB
RUN apt-get update
RUN apt-get install -y mongodb-org

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS="" REGION="us-east-1"

ENV CRON_D_BACKUP="0 1,9,17 * * * root   /backup.sh | logger\n"

COPY backup.sh restore.sh /

RUN chmod +x /backup.sh
RUN chmod +x /restore.sh
