# Minimal Docker image for uDance_insertion using Debian minimal base
FROM debian:10.10-slim
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# prep environment
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python3 python3-pip unzip wget && \
    ln -s $(which python3) /usr/local/bin/python && \
    pip3 install --no-cache-dir apples dendropy pandas scipy && \
    wget -qO- "https://github.com/shenwei356/seqkit/releases/download/v2.0.0/seqkit_linux_amd64.tar.gz" | tar -zx && \
    mv seqkit /usr/local/bin/ && \
    wget -qO- "https://github.com/Niema-Docker/newick-utils/raw/main/newick-utils-1.6-Linux-x86_64-disabled-extra.tar.gz" | tar -zx && \
    mv newick-utils-*/src/nw_* /usr/local/bin/ && \
    wget -qO- "https://github.com/stamatak/standard-RAxML/archive/refs/tags/v8.2.12.tar.gz" | tar -zx && \
    cd standard-RAxML-* && \
    for mf in Makefile*.PTHREADS.gcc ; do make -f "$mf" ; done && \
    mv raxml* /usr/local/bin/ && \
    cd .. && \
    wget -qO- "https://github.com/Niema-Docker/udance_insertion/raw/main/uDance_insertion_pipeline_2021-08-31.tar.gz" | tar -zx && \
    sed -i 's/^module load/#module load/g' uDance_insertion_pipeline/run.sh && \
    sed -i 's/^eval /#eval /g' uDance_insertion_pipeline/run.sh && \
    sed -i 's/^conda activate/#conda activate/g' uDance_insertion_pipeline/run.sh && \
    mv uDance_insertion_pipeline /usr/local/bin/ && \
    ln -s /usr/local/bin/uDance_insertion_pipeline/run.sh /usr/local/bin/run_uDance_insertion.sh && \
    mkdir -p /usr/local/bin/scripts && \
    for f in /usr/local/bin/uDance_insertion_pipeline/scripts/* ; do ln -s "$f" "/usr/local/bin/scripts/$(echo $f | rev | cut -d'/' -f1 | rev)" ; done && \
    rm -rf newick-utils-* standard-RAxML-*
