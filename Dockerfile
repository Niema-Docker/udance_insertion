# Minimal Docker image for uDance_insertion using Debian minimal base
FROM debian:10.10-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# prep environment
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python3 python3-pip wget && \
    pip3 install --no-cache-dir dendropy pandas scipy seqkit && \
    wget -qO- "https://github.com/Niema-Docker/udance_insertion/raw/main/uDance_insertion_pipeline_2021-08-31.tar.gz" | tar -zx && \
    # TODO
