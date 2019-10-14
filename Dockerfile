FROM ubuntu:18.04

#some_ important _library
RUN apt-get update && apt-get install wget build-essential gcc make -y
RUN apt-get install common-software-properties  -y

#Install_JAVA
RUN apt-get install default-jdk -y
RUN apt-get install openjdk-8-jre -y
RUN apt-get update
RUN wget -O - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
RUN apt-get update &&  apt-get install elasticsearch -y
RUN apt-get install git -y
RUN apt-get install python3.7 -y
RUN apt-get install python3-pip
RUN pip3 install elasticsearch urllib3==1.24.1 jsonschema==2.6.0 wheel pandas
RUN apt-get install vim  -y#configuration_to_PubilsOverSSHRUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
RUN service ssh restart

COPY ./script /script


