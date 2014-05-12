## Tengine Dockerfile


A distribution of [Nginx](http://nginx.org) with some advanced features 
[http://tengine.taobao.org](http://tengine.taobao.org)


### Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Installation

1. Install [Docker](https://www.docker.io/).

2. Download [trusted build](https://index.docker.io/u/mimosa/tengine) from public [Docker Registry](https://index.docker.io/): `docker pull mimosa/tengine`

   (alternatively, you can build an image from Dockerfile: `docker build -t="mimosa/tengine" github.com/mimosa/docker-tengine`)


### Usage

    docker run -d -p 80:80 mimosa/tengine

#### Attach persistent/shared directories

    docker run -d -p 80:80 -v <sites-enabled-dir>:/etc/nginx/sites-enabled -v <log-dir>:/var/log/nginx dockerfile/nginx

After few seconds, open `http://<host>` to see the welcome page.
