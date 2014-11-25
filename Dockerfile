# Pull base image.
FROM ubuntu:14.04

MAINTAINER David Wisner dwisner6@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C

RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-stable-trusty.list

RUN apt-get update
RUN apt-get install -y --only-upgrade bash
RUN apt-get install -y wget nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

VOLUME ["/etc/nginx/certs"]

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.3.4
ENV DOCKER_HOST unix:///tmp/docker.sock

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
RUN tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && rm docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN mkdir /app
WORKDIR /app
ADD . /app

EXPOSE 80 
EXPOSE 443

CMD ["forego", "start", "-r"]