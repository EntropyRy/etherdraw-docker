# Etherdraw Dockerfile
#
# https://github.com/EntropyRy/etherdraw-docker
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM node:0.12
MAINTAINER John E. Arnold, iohannes.eduardus.arnold@gmail.com

# Get Etherdraw's other dependencies
RUN apt-get update
RUN apt-get install -y gzip git-core libpango1.0-dev curl python libssl-dev pkg-config build-essential supervisor g++

# Grab the latest Git version
RUN cd /opt && git clone https://github.com/JohnMcLear/draw.git etherdraw

# Install node dependencies
RUN /opt/etherdraw/bin/installDeps.sh

# Add conf files
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD settings.json /opt/etherdraw/settings.json

EXPOSE 9002
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
