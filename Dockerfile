FROM debian:jessie

COPY ./script /script


RUN apt-get update && \
    apt-get install -y openjdk-7-jre wget
RUN apt-get install python3-pip

RUN pip install elasticsearch
RUN pip install urllib3==1.24.1
RUN pip install jsonschema==2.6.0
RUN pip install wheel
RUN pip install pandas

ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64
RUN (cd /tmp && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-7.3.2-linux-x86_64.tar.gz -O pkg.tar.gz && \
    tar zxf pkg.tar.gz && mv elasticsearch-* /opt/elasticsearch &&\
    rm -rf /tmp/*)
COPY elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
EXPOSE 9200
EXPOSE 9300
VOLUME /opt/elasticsearch/data
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
CMD []

