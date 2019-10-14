FROM ubuntu:16.04
COPY ./script /script

# Setup python and java and base system
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -q -y openjdk-8-jdk python3-pip libsnappy-dev language-pack-en supervisor

RUN pip3 install --upgrade pip requests elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas




