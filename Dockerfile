FROM ubuntu:16.04
COPY ./script /script

# Setup python and java and base system
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -q -y openjdk-8-jdk python3-pip libsnappy-dev language-pack-en supervisor sudo wget

RUN pip3 install --upgrade pip requests 
RUN pip3 install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas
#ELASTICSEARCH
RUN sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch 
RUN sudo apt-key add GPG-KEY-elasticsearch -
RUN apt-get install apt-transport-https
RUN "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
RUN apt-get update && sudo apt-get install elasticsearch
RUN service elasticsearch start


