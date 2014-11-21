# Pull base image.
FROM debian:wheezy

MAINTAINER David Wisner dwisner6@gmail.com

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list.d/nginx.list

RUN apt-get update && apt-get install -y \
        autoconf \
        build-essential \
        nginx \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

VOLUME ["/etc/nginx/certs"]

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.3.4

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
RUN tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && rm docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN mkdir /app
WORKDIR /app
ADD . /app

EXPOSE 80 
EXPOSE 443

ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]