FROM debian:jessie

COPY ./script /script

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install python3.6
RUN apt-get install -y openjdk-7-jre wget
RUN apt-get install -y python3-pip 

RUN pip3 install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas

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

