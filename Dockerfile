FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.4
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install \ 
-b http://es-learn-to-rank.labs.o19s.com/ltr-1.1.0-es6.2.4.zip

FROM python:3.7

COPY ./script /script
WORKDIR /script

RUN pip install elasticsearch

ENTRYPOINT ["python"]

