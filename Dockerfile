
FROM python:3.8.0rc1-alpine3.10

COPY ./script script
RUN pip install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas

WORKDIR /var/www/

# Include dist
ADD dist/ /root/dist/
#
# Setup env and apt
RUN sed -i 's/dl-cdn/dl-2/g' /etc/apk/repositories && \
    apk -U --no-cache add \
             aria2 \
             bash \
             curl \
             nss \
             openjdk8-jre && \
#
# Get and install packages
    cd /root/dist/ && \
    mkdir -p /usr/share/elasticsearch/ && \
    aria2c -s 16 -x 16 https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.2.tar.gz && \
    tar xvfz elasticsearch-6.8.2.tar.gz --strip-components=1 -C /usr/share/elasticsearch/ && \
#
# Add and move files
    cd /root/dist/ && \
    mkdir -p /usr/share/elasticsearch/config && \
    cp elasticsearch.yml /usr/share/elasticsearch/config/ && \
#
# Setup user, groups and configs
    addgroup -g 2000 elasticsearch && \
    adduser -S -H -s /bin/ash -u 2000 -D -g 2000 elasticsearch && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/ && \
    rm -rf /usr/share/elasticsearch/modules/x-pack-ml && \
#
# Clean up
    apk del --purge aria2 && \
    rm -rf /root/* && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*
#
# Healthcheck
HEALTHCHECK --retries=10 CMD curl -s -XGET 'http://127.0.0.1:9200/_cat/health'
#
# Start ELK
USER elasticsearch:elasticsearch
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]

WORKDIR ./
