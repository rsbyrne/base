FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

RUN umask 0000
ENV WORKSPACE $HOME/workspace
RUN mkdir $WORKSPACE
WORKDIR $WORKSPACE
ENV BASEDIR $WORKSPACE/base
RUN mkdir $BASEDIR
ADD . $BASEDIR
ENV MOUNTDIR $WORKSPACE/mount
VOLUME $MOUNTDIR

RUN useradd -p $(openssl passwd -1 'Morpheus-1999!') morpheus
#USER morpheus

#RUN apt update

#RUN apt-get update -y
#RUN apt-get install -y software-properties-common
#RUN apt-get install -y curl
#RUN apt-get install -y wget
#RUN apt-get install -y git
#RUN apt-get install -y nano
#RUN apt-get install -y ffmpeg
#RUN apt-get install -y apache2

WORKDIR $WORKSPACE
