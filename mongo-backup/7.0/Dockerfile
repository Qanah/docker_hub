FROM nickbreen/cron:v1.0.0

RUN apt-get -qqy upgrade

# Update package lists and install required packages
RUN apt-get -qqy update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2-utils python3-pip && \
    apt-get -qqy clean

# Install s3cmd using pip3
RUN pip3 install s3cmd

# Add MongoDB repository key
RUN apt-get update && apt-get install -y wget gnupg && \
    wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -

# Add MongoDB repository to sources list
RUN echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Update package lists and install MongoDB
RUN apt-get update && \
    apt-get install -qqy mongodb-org && \
    apt-get clean

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS="" REGION="us-east-1"

ENV CRON_D_BACKUP="0 1,9,17    * * * root   /backup.sh | logger\n"

COPY backup.sh restore.sh /

RUN chmod +x /backup.sh
RUN chmod +x /restore.sh
