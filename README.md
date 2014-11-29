nginx-ssl-proxy
===============

Docker nginx reverse proxy based on [nginx-proxy](https://github.com/jwilder/nginx-proxy), but with ssl support! Uses nginx v

[![latest](https://img.shields.io/badge/docker-latest-blue.svg?style=flat-square)]https://registry.hub.docker.com/u/rnbwd/nginx-ssl-proxy/)

![latest](https://img.shields.io/badge/version-0.1.2-lightgrey.svg?style=flat-square)

## Usage

 - To run it

`docker run -d -p 80:80 -p 443:443 -v <certs-dir>:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock rnbwd/nginx-ssl-proxy`

Linking ssl certs works the same as the official [nginx dockerfile](https://github.com/dockerfile/nginx).  

Start any containers you want proxied with an env var `VIRTUAL_HOST=foo.bar.com` and an optional env var `REDIRECT=true` to redirect all requests to HTTPS. 

`docker run -e VIRTUAL_HOST=foo.bar.com  -e REDIRECT=true ...`

Just switch 'foo.bar.com' with your personal domain name. 

## Caveats

- SSL certificates are connected by host name, **so make sure that 'foo.bar.com.crt' and 'foo.bar.com.key' exist in the certs directory before running.**

- Wildcard ssl certs aren't supported yet, so each host name requires its own cert. 

- Host names without subdomains, like 'bar.com', work the same.

- For TLS SNI support run

`docker run -it --rm rnbwd/nginx-ssl-proxy nginx -V | grep -i sni`

- This is an experimental fork of [nginx-proxy](https://github.com/jwilder/nginx-proxy), so use at your own risk (or help me make it better and/or integrate with nginx-proxy)
