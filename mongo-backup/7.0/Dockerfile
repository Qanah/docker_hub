FROM nickbreen/cron:v1.0.0

RUN apt-get -qqy upgrade

# Update package lists and install required packages
RUN apt-get -qqy update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2-utils python3-pip && \
    apt-get -qqy clean

# Install s3cmd using pip3
RUN pip3 install s3cmd

# Update package lists
RUN apt-get update

# Install necessary dependencies
RUN apt-get install -y gnupg curl

# Add MongoDB repository to sources list
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install MongoDB
RUN apt-get update
RUN apt-get install -y mongodb-org

ENV ACCESS_KEY="" SECRET_KEY="" BUCKET="" DBS="" REGION="us-east-1"

ENV CRON_D_BACKUP="0 1,9,17 * * * root   /backup.sh | logger\n"

COPY backup.sh restore.sh /

RUN chmod +x /backup.sh
RUN chmod +x /restore.sh
