FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

ENV MASTERUSER morpheus

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y sudo
RUN apt-get install -y vim

# configure master user
RUN useradd -p $(openssl passwd -1 'Matrix-1999!') $MASTERUSER
RUN usermod -aG sudo $MASTERUSER

# configure user directories
ENV MORPHEUSHOME /home/$MASTERUSER
RUN mkdir /home/$MASTERUSER
ENV WORKSPACE $$MASTERUSERHOME/workspace
RUN mkdir $WORKSPACE
ENV TOOLS $$MASTERUSERHOME/tools
RUN mkdir $TOOLS
ENV MOUNTDIR $WORKSPACE/mount
VOLUME $MOUNTDIR
ENV BASEDIR $$MASTERUSERHOME/base
ADD . $BASEDIR
RUN chown -R $MASTERUSER $$MASTERUSERHOME

# set up passwordless sudo
RUN echo '$MASTERUSER ALL = (ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

# install other softwares
#RUN apt-get install -y curl
#RUN apt-get install -y wget
#RUN apt-get install -y git
#RUN apt-get install -y nano
#RUN apt-get install -y ffmpeg
#RUN apt-get install -y apache2

# change to master user
USER $MASTERUSER
WORKDIR $HOME

# junk
#RUN apt update
