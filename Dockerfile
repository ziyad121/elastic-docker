FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.4
RUN ./ install \ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.3.2-windows-x86_64.zip

FROM python:3.7

COPY ./script /script

RUN pip install elasticsearch
RUN pip install urllib3==1.24.1
RUN pip install jsonschema==2.6.0
RUN pip install wheel
RUN pip install pandas

ENTRYPOINT ["python"]

