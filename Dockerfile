FROM debian:jessie
RUN apt-get update && \
    apt-get install -y openjdk-7-jre wget
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
RUN (cd /tmp && \
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.tar.gz -O pkg.tar.gz && \
    tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch &&\
    rm -rf /tmp/*)
COPY elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
EXPOSE 9200
EXPOSE 9300
VOLUME /opt/elasticsearch/data
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
CMD []

FROM python:3.7
COPY ./script /script

RUN pip install elasticsearch
RUN pip install urllib3==1.24.1
RUN pip install jsonschema==2.6.0
RUN pip install wheel
RUN pip install pandas

