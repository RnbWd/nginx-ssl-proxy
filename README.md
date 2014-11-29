nginx-ssl-proxy 
===============

## Docker

[![latest][docker-badge]](https://registry.hub.docker.com/u/rnbwd/nginx-ssl-proxy/)
[![nginx][nginx-badge]](http://nginx.org/en/CHANGES)

`docker pull rnbwd/nginx-ssl-proxy`

[docker-badge]: https://img.shields.io/badge/docker-0.1.2-blue.svg?style=flat-square
[nginx-badge]: https://img.shields.io/badge/nginx-1.7.7-orange.svg?style=flat-square

### Usage

```
$ docker run -d -p 80:80 -p 443:443 -v <certs-dir>:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock rnbwd/nginx-ssl-proxy
```

`docker run -e VIRTUAL_HOST=foo.bar.com  -e REDIRECT=true [...]`

## Important Info

- SSL certificates are connected by host name, **make sure that 'foo.bar.com.crt' and 'foo.bar.com.key' exist in the certs directory (<certs-dir>).**

- [nginx.tmpl](https://github.com/RnbWd/nginx-ssl-proxy/blob/master/nginx.tmpl) contains nginx configuration based on https://wiki.mozilla.org/Security/Server_Side_TLS#Nginx

- For TLS SNI support run

`docker run -it --rm rnbwd/nginx-ssl-proxy nginx -V | grep -i sni`

## Links

- [Automated Nginx Reverse Proxy for Docker][1]

- [nginx-proxy][2]

- [docker-gen][3]

## MIT Licenced

[1]: http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/
[2]: https://github.com/jwilder/nginx-proxy
[3]: https://github.com/jwilder/docker-gen



