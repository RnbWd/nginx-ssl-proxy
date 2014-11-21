nginx-ssl-proxy
===============

Docker nginx ssl reverse proxy

## Usage

Build

    $ docker build -t nginx-proxy .

Run

````
    $ docker run -d -p 80:80 -p 443:443 \
    $ -v /var/run/docker.sock:/tmp/docker.sock nginx-proxy \
    $ -v <certs-dir>:/etc/nginx/certs
````

Then start any containers you want proxied with an env var `VIRTUAL_HOST=subdomain.youdomain.com`

    $ docker run -e VIRTUAL_HOST=foo.bar.com  -e REDIRECT=true ...