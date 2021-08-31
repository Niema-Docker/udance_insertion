# Minimal Docker image for uDance_insertion using Debian minimal base
FROM debian:10.10-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# prep environment
RUN apt-get update && \
    apt-get -y upgrade && \
