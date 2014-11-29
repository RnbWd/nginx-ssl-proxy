nginx-ssl-proxy 
===============

## Docker

[![latest][docker-latest]][docker] 
[![version][version-badge]](#usage)

`docker pull rnbwd/nginx-ssl-proxy`

[docker]: https://registry.hub.docker.com/u/rnbwd/nginx-ssl-proxy/
[docker-latest]: https://img.shields.io/badge/docker-latest-blue.svg?style=flat-square
[version-badge]: https://img.shields.io/badge/version-0.1.2-lightgrey.svg?style=flat-square

 - Usage

`docker run -d -p 80:80 -p 443:443 -v <certs-dir>:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock rnbwd/nginx-ssl-proxy`

`docker run -e VIRTUAL_HOST=foo.bar.com  -e REDIRECT=true ...`

## Info

[![nginx][nginx-badge][nginx-verion]]

[nginx-badge]: https://img.shields.io/badge/nginx--version-1.7.7-orange.svg?style=flat-square
[nginx-verson]: (http://nginx.org/en/CHANGES)

- SSL certificates are connected by host name, **so make sure that 'foo.bar.com.crt' and 'foo.bar.com.key' exist in the certs directory before running.**

- Wildcard ssl certs aren't supported yet, so each host name requires its own cert. 

- Host names without subdomains, like 'bar.com', work the same.

- For TLS SNI support run

`docker run -it --rm rnbwd/nginx-ssl-proxy nginx -V | grep -i sni`

- This is an experimental fork of [nginx-proxy](https://github.com/jwilder/nginx-proxy), so use at your own risk (or help me make it better and/or integrate with nginx-proxy)

## MIT Licenced



