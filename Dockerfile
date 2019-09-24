
FROM python

COPY ./script /script

RUN pip install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas
