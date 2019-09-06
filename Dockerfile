FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.1

RUN apt-get update && apt-get install -y python3
RUN pip install elasticsearch

COPY ./script /script

