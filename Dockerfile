# Minimal Docker image for uDance_insertion using Debian minimal base
FROM debian:10.10-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# prep environment
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python3 python3-pip unzip wget && \
    pip3 install --no-cache-dir apples dendropy pandas scipy && \
    wget -qO- "https://github.com/shenwei356/seqkit/releases/download/v2.0.0/seqkit_linux_amd64.tar.gz" | tar -zx && \
    mv seqkit /usr/local/bin/ && \
    wget -qO- "https://github.com/Niema-Docker/newick-utils/raw/main/newick-utils-1.6-Linux-x86_64-disabled-extra.tar.gz" | tar -zx && \
    mv newick-utils-*/src/nw_* /usr/local/bin/ && \
    wget "https://github.com/amkozlov/raxml-ng/releases/download/1.0.3/raxml-ng_v1.0.3_linux_x86_64.zip" && \
    unzip -d raxml-ng raxml-ng_v1.0.3_linux_x86_64.zip && \
    mv raxml-ng/raxml-ng /usr/local/bin/ && \
    wget -qO- "https://github.com/Niema-Docker/udance_insertion/raw/main/uDance_insertion_pipeline_2021-08-31.tar.gz" | tar -zx && \
    rm -rf newick-utils-* raxml-ng*
