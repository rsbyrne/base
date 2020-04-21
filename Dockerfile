FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y sudo

#RUN apt-get install -y curl
#RUN apt-get install -y wget
#RUN apt-get install -y git
#RUN apt-get install -y nano
#RUN apt-get install -y ffmpeg
#RUN apt-get install -y apache2

RUN useradd -p $(openssl passwd -1 'Morpheus-1999!') morpheus
RUN usermod -aG sudo morpheus
ENV MORPHEUSHOME /home/morpheus
RUN mkdir /home/morpheus
ENV WORKSPACE $MORPHEUSHOME/workspace
RUN mkdir $WORKSPACE
ENV TOOLS $MORPHEUSHOME/tools
RUN mkdir $TOOLS
ENV MOUNTDIR $WORKSPACE/mount
VOLUME $MOUNTDIR
ENV BASEDIR $MORPHEUSHOME/base
ADD . $BASEDIR
RUN chown -R morpheus $MORPHEUSHOME

USER morpheus
WORKDIR $HOME

#RUN apt update
