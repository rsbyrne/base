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
#RUN mkdir $MOUNTDIR
VOLUME $MOUNTDIR

RUN apt update

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y python3-venv
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y ffmpeg
RUN apt-get install -y apache2
RUN alias python=python3
RUN apt-get install -y python3-pip
# Install miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda

ENV PYTHONPATH "${PYTHONPATH}:$WORKSPACE"
ENV PYTHONPATH "${PYTHONPATH}:$MOUNTDIR"
ENV PYTHONPATH "${PYTHONPATH}:$BASEDIR"

RUN useradd -p $(openssl passwd -1 'Morpheus-1999!') morpheus
USER morpheus

WORKDIR $WORKSPACE
