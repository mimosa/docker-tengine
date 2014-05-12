#
# Nginx Dockerfile
#
# https://github.com/mimosa/docker-tengine
#

# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Howl王 <howl.wong@gmail.com>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq

# Basic Requirements
RUN apt-get install -y build-essential debhelper make autoconf automake patch
RUN apt-get install -y dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev git-core

# Create Nginx user
RUN adduser --disabled-login --gecos 'Tengine' nginx 

# Install Tengine Shell
WORKDIR /home/nginx
RUN su nginx -c 'git clone https://github.com/alibaba/tengine.git'

WORKDIR /home/nginx/tengine
RUN su nginx -c 'mv packages/debian .'

ENV DEB_BUILD_OPTIONS nocheck

RUN su nginx -c 'dpkg-buildpackage -rfakeroot -uc -b'

WORKDIR /home/nginx
RUN dpkg -i tengine_2.0.2-1_amd64.deb

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