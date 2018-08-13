
Starting point for a Docker Web Server
======================================

Nginx proxy containers
----------------------
This container provides virtual host routing of requests on port 80 to nginx containers registered with their host name.


Logspout which logs to papertrail
---------------------------------
This container forwards all log output on stdout and stderr to papertrail.

Development machine setup
-------------------------

1. Install Docker
   https://docs.docker.com/engine/installation/

2. Install Docker Compose:
   https://docs.docker.com/compose/install/

3. Clone the Docker Web Server
   ```
   git clone https://github.com/dylangmiles/docker-webserver.git docker-webserver
   ```
4. Add the following environment variable to your .profile
   ```
   export HOSTNAME=<yourhostname>
   ```
5. Run `./create-local-crt.sh` to generate .local and localhost self signed certificates into `data/certs`.   
    
6. Add `data/certs/local.crt` and `data/certs/localhost.crt` to your locally trusted certificate store


Production Server Setup
-----------------------
1. Install Docker
   https://docs.docker.com/engine/installation/

2. Install Docker Compose:
   https://docs.docker.com/compose/install/

3. Clone the Docker Web Server
   ```
   git clone https://github.com/dylangmiles/docker-webserver.git docker-webserver
   ```
4. Add the following environment variable to your .profile
   ```
   export HOSTNAME=<yourhostname>
   ```

Start the services
------------------
```
docker-compose up -d server
```

```
docker-compose up -d logspout
```

Once you start your other services you should be able to browse to them with with their domain name on port 80!
