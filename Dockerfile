FROM docker.elastic.co/elasticsearch/elasticsearch:7.3.1
MAINTAINER ziyad_meftah
COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/

FROM python:3.7

COPY ./script /script
WORKDIR /script

RUN pip install -r elasticsearch

ENTRYPOINT ["python"]

