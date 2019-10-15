FROM ubuntu:16.04
COPY ./script /script

# Setup python and java and base system
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -q -y openjdk-8-jdk python3-pip libsnappy-dev language-pack-en supervisor sudo wget dbus-user-session

RUN pip3 install --upgrade pip requests 
RUN pip3 install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas
#ELASTICSEARCH
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-linux-x86_64.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-linux-x86_64.tar.gz.sha512
RUN shasum -a 512 -c elasticsearch-7.4.0-linux-x86_64.tar.gz.sha512 
RUN tar -xzf elasticsearch-7.4.0-linux-x86_64.tar.gz

RUN addgroup -S es
RUN adduser -S -D -h elastic es

RUN chown -R elastic:es elasticsearch-7.4.0
USER elastic 

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300 

# Define default command.
CMD ["/elasticsearch-7.4.0/bin/elasticsearch"]


