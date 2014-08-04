# Docker-Conscript-g8 example
# VERSION 1.0

# the base image is a trusted ubuntu build with java 7 (https://index.docker.io/u/dockerfile/java/)
FROM dockerfile/java

# we need this because the workdir is modified in dockerfile/java
# 20140803-kg-changed from / to /root given https://github.com/docker/docker/issues/6619
WORKDIR /root

ENV HOME /root
RUN cd /tmp && wget --no-check-certificate https://raw.githubusercontent.com/n8han/conscript/master/setup.sh
RUN sh /tmp/setup.sh
RUN /root/bin/cs n8han/giter8
RUN ln -s /root/bin/cs /usr/local/bin
RUN ln -s /root/bin/g8 /usr/local/bin
