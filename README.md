# Docker Web Server

## NGINX proxy
jwilder/nginx-proxy: This container provides virtual host routing of requests on port 80/443 to nginx containers registered with their host name. 

## NGINX proxy companion
jwilder/nginx-proxy: Generates certificates for https using LetsEncrypt


## Development machine setup

1. Install Docker and Docker Compose
   https://docs.docker.com/get-docker

2. Clone the Docker Web Server
   ```
   git clone https://github.com/dylangmiles/docker-webserver.git docker-webserver
   ```
4. Create a .env file in the application directory with the following values
   ```
   HOSTNAME=<yourhostname>
   ```
5. Run `./create-local-crt.sh` to generate .local and localhost self signed certificates into `data/certs`.   
    
6. Add `data/certs/local.crt` and `data/certs/localhost.crt` to your locally trusted certificate store


## Production Server Setup
1. Install Docker and Docker Compose
   https://docs.docker.com/get-docker

2. Clone the Docker Web Server
   ```
   git clone https://github.com/dylangmiles/docker-webserver.git docker-webserver
   ```
3. Create a .env file in the application directory with the following values:
   ```
   export HOSTNAME=<yourhostname>
   ```

## Override proxy paramterers
To override NGINX parameters you can edit my_proxy.conf

## Start the services
```
docker-compose up -d server
```

## Set up a dependent web application
When setting up web applications in other docker compose configurations you can use environment variables to allow the proxy to route requests

```shell
# .env file for dependent web application

FQDN=web.myapp.example
EMAIL=admin@myapp.example


# docker-compose.yml file of a dependant web application running on the server
version: '3.4'
services:
  
  ...
  
  web:
    ...
    environment:
      
      ...
      
      ## Variables to which the proxy and server containers use to route to this application based on the host name
      - VIRTUAL_HOST=${FQDN}
      - LETSENCRYPT_HOST=${FQDN}
      - LETSENCRYPT_EMAIL=${EMAIL}

## The containers in this web app must be part of the same network as the proxy and server containers.
networks:
  default:
    name: internet


```

