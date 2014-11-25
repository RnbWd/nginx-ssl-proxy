nginx-ssl-proxy
===============

Docker nginx reverse proxy with ssl support - forked from [nginx-proxy](https://github.com/jwilder/nginx-proxy). SSL certs are required to use this image, they are not generated automatically.

## Usage

 - To run it

`docker run -d -p 80:80 -p 443:443 -v <certs-dir>:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock rndwb/nginx-ssl-proxy`

The certs directory is linked in the locally (eg. `/var/local/certs`) and works the same as the official [nginx dockerfile](https://github.com/dockerfile/nginx).  

Then start any containers you want proxied with an env var `VIRTUAL_HOST=subdomain.youdomain.com`

    $ docker run -e VIRTUAL_HOST=foo.bar.com  -e REDIRECT=true ...


