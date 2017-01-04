#
# Nginx Dockerfile
#
# https://github.com/mimosa/docker-tengine
#

# Pull base image.
FROM ubuntu:latest
MAINTAINER Howl王 <howl.wong@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq

# Basic Requirements
RUN apt-get install -qq -y curl  unzip 
RUN apt-get install -qq -y dpkg-dev debhelper libssl-dev libpcre3-dev zlib1g-dev

# Create Nginx user
RUN adduser --disabled-login --gecos 'Tengine' nginx 

# Install Tengine Shell
WORKDIR /home/nginx
RUN su nginx -c 'curl -sL https://github.com/alibaba/tengine/archive/master.zip >> tengine.zip'
RUN su nginx -c 'unzip -x tengine.zip'
RUN su nginx -c 'rm -fr tengine.zip'

WORKDIR /home/nginx/tengine-master
RUN su nginx -c 'mv packages/debian .'

# Skip tests
ENV DEB_BUILD_OPTIONS nocheck

RUN su nginx -c 'dpkg-buildpackage -rfakeroot -uc -b'

WORKDIR /home/nginx
RUN dpkg -i tengine_2*_amd64.deb

# Define mountable directories.
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

# 
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
