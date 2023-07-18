# Traefik Dockerized

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Modules](#modules)
- [Resources](#resources)

---

## Overview

This repository contains a template to deploy [Traefik 2](https://containo.us/traefik/) using [Docker Compose](https://docs.docker.com/compose/) on a single machine running [Docker](https://www.docker.com/). This template contains support for the following modules 
 - [Traefik Dashboard](#traefik-dashboard)
 - [minica](#minica)
 - [Mariadb](#mariadb)
 - [Redis](#redis)
 - [Redis Commander](#redis-commander)
 - [Mailhog](#mailhog)

## Requirements

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

## Installation

Clone the repository:

```sh
$ git clone https://github.com/Devin345458/traefik-dockerized.git
Cloning into 'traefik-dockerized'...
```

Create your shared network:

```sh
$ docker network create nginx-proxy
```

Start the container by running the following command from the root directory

```sh
# Make sure docker is running first
$ docker-compose up -d
```

Add Minica Pem to your trust store
###### Mac
Drag the file ```certs/minica.pem``` into your keychain and trust it

###### Windows
Double click the file ```certs/minica.pem``` and click install certificate. Select Local Machine and place it in the Trusted Root Certification Authorities store


## Usage

Once the configuration is completed, you can use this to route all your docker containers through traefik. To do this you need to add the following labels to your docker-compose file

```yaml
- traefik.http.routers.$DOCKER_ROUTER.rule=Host(`$DOCKER_DOMAIN`)
- traefik.http.routers.$DOCKER_ROUTER.tls=true
- traefik.http.routers.$DOCKER_ROUTER.entrypoints=https
- traefik.http.services.$DOCKER_ROUTER.loadbalancer.server.port=80
```

``$DOCKER_ROUTER`` - This will be the name of your project with no `.` in it i.e. ``traefik-dockerized``

``$DOCKER_DOMAIN`` - This will be the domain you would like to access the site on this must be either a .localhost domain or a domain that is pointed to 127.0.0.1 by your hosts file


## Modules

### Traefik Dashboard

This is the traefik dashboard. It can be accessed on https://traefik.localhost

### Minica

This is a service that runs behind the scene. Anytime you add a new container using the labels above it will automatically generate a certificate for that domain and add it to your trust store. This will allow you to access the site over https without any warnings

### Mariadb

This is a mariadb instance. It will be available in your docker network as ``mariadb`` and can be accessed on port ``3306`` or from your local machine on ``localhost`` port ``3306``

### Redis

This is a redis instance. It will be available in your docker network as ``redis`` and can be accessed on port ``6379`` or from your local machine on ``localhost`` port ``6379``

### Redis Commander

This is a redis commander instance. It can be accessed on https://redis.localhost and will connect to your redis instance on ``redis`` port ``6379`` so you can see the key currently in the storage

### Mailhog

This is a mail capturing service. It can be accessed on https://mailhog.localhost and will capture all emails sent from your docker containers if you set your SMTP server to host ``mailhog`` port ``1025``

### Minio

This is local S3 storage. It can be accessed on https://minio-console.localhost and will store all files in the ``/storage/minio`` directory. In order to use it you must set your S3 server to host ``minio`` port `` 9000``

### Notes
You can modify any of these urls by changing the ``docker-compose.yml`` file. You just need to update the ``traefik.http.routers.$SERVICE.rule=Host(`$DOCKER_DOMAIN`)`` to the domain you would like to use

## Resources

- [Traefik](https://containo.us/traefik/)
- [Traefik Documentation](https://docs.traefik.io/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Minica](https://github.com/bjornsnoen/minica-api/pkgs/container/minica-traefik-api)
- [Mysql](https://mariadb.com/)
- [Redis](https://redis.com/)
- [Redis Commander](https://github.com/joeferner/redis-commander)
- [Mailhog](https://github.com/mailhog/MailHog)
- [Minio](https://github.com/minio/minio)
