FROM docker.elastic.co/elasticsearch/elasticsearch:6.2.4
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install \ 
-b es-learn-to-rank.labs.o19s.com/ltr-1.1.2-es7.3.1.zip


FROM python:3.7
COPY ./script /script

RUN pip install elasticsearch
RUN pip install urllib3==1.24.1
RUN pip install jsonschema==2.6.0
RUN pip install wheel
RUN pip install pandas

ENTRYPOINT ["python"]

