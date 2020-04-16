FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

RUN umask 0000
ENV WORKSPACE /workspace
RUN mkdir $WORKSPACE
WORKDIR $WORKSPACE
ENV BASEDIR $WORKSPACE/base
RUN mkdir $BASEDIR
ADD . $BASEDIR
ENV MOUNTDIR $WORKSPACE/mount
RUN mkdir $MOUNTDIR

RUN apt update

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y python3-venv
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y ffmpeg
RUN alias python=python3
RUN apt-get install -y python3-pip

ENV PYTHONPATH "${PYTHONPATH}:$WORKSPACE"
ENV PYTHONPATH "${PYTHONPATH}:$BASEDIR"
ENV PYTHONPATH "${PYTHONPATH}:$MOUNTDIR"

WORKDIR $WORKSPACE

RUN pip3 install --no-cache-dir scipy
RUN pip3 install --no-cache-dir pandas
RUN pip3 install --no-cache-dir Pillow
RUN pip3 install --no-cache-dir bokeh
RUN pip3 install --no-cache-dir Flask
RUN pip3 install --no-cache-dir dask[complete]
RUN pip3 install --no-cache-dir scikit-learn
RUN pip3 install --no-cache-dir tensorflow
RUN pip3 install --no-cache-dir jupyterlab

RUN apt install apache2
