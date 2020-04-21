FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

ENV MASTERUSER morpheus
ENV MASTERPASSWD Matrix-1999!

# install softwares required for subsequent steps
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y sudo
RUN apt-get install -y vim

# configure master user
RUN useradd -p $(openssl passwd -1 '$MASTERPASSWD') $MASTERUSER
RUN usermod -aG sudo $MASTERUSER

# configure user directories
ENV MASTERUSERHOME /home/$MASTERUSER
RUN mkdir $MASTERUSERHOME
ENV WORKSPACE $MASTERUSERHOME/workspace
RUN mkdir $WORKSPACE
ENV TOOLS $MASTERUSERHOME/tools
RUN mkdir $TOOLS
ENV MOUNTDIR $WORKSPACE/mount
VOLUME $MOUNTDIR
ENV BASEDIR $MASTERUSERHOME/base
ADD . $BASEDIR
RUN chown -R $MASTERUSER $MASTERUSERHOME

# set up passwordless sudo for master user
RUN echo '$MASTERUSER ALL = (ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

# change to master user
USER $MASTERUSER
WORKDIR $HOME

# install other softwares
#RUN sudo apt-get install -y curl
#RUN sudo apt-get install -y wget
#RUN sudo apt-get install -y git
#RUN sudo apt-get install -y nano
#RUN sudo apt-get install -y ffmpeg
#RUN sudo apt-get install -y apache2

# junk
#RUN apt update
