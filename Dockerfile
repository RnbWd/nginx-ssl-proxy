# Pull base image.
FROM ubuntu:14.04

MAINTAINER David Wisner dwisner6@gmail.com

# Install nginx version: nginx/1.7.7
RUN echo "deb http://ppa.launchpad.net/chris-lea/nginx-devel/ubuntu trusty main " > /etc/apt/sources.list.d/nginx-stable.list
RUN echo "deb-src http://ppa.launchpad.net/chris-lea/nginx-devel/ubuntu trusty main " >> /etc/apt/sources.list.d/nginx-stable.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12 

RUN apt-get update
RUN apt-get install -y -q --no-install-recommends \
    ca-certificates \
    nginx \
    wget \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# Configure Nginx and apply fix for long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.3.4
VOLUME ["/etc/nginx/certs"]

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY . /app/
WORKDIR /app

EXPOSE 80 
EXPOSE 443
ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
