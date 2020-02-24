FROM ubuntu:bionic-20200112
MAINTAINER https://github.com/rsbyrne/

RUN umask 0000
ENV WORKSPACE /workspace/
RUN mkdir $WORKSPACE
WORKDIR $WORKSPACE
ENV BASEDIR $WORKSPACE/base/
RUN mkdir $BASEDIR
ADD . $BASEDIR
ENV MOUNTDIR $WORKSPACE/mount/
RUN mkdir $MOUNTDIR

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN apt-get install -y python3-venv
RUN apt-get install -y git
RUN apt-get install -y nano
RUN apt-get install -y ffmpeg
RUN alias python=python3
RUN apt-get install -y python3-pip

RUN export PYTHONPATH=$PYTHONPATH:$WORKSPACE
RUN export PYTHONPATH=$PYTHONPATH:$BASEDIR
RUN export PYTHONPATH=$PYTHONPATH:$MOUNTDIR

RUN pip3 install --no-cache-dir scons
RUN apt-get install -y libxml2-dev
RUN apt-get install -y swig
RUN apt-get install -y petsc-dev
RUN apt-get install -y mpich
RUN apt-get install -y openmpi-bin
RUN pip3 install --no-cache-dir mpi4py
RUN apt-get install -y libhdf5-mpi-dev
RUN pip3 install --no-cache-dir h5py
RUN apt-get install -y build-essential libgl1-mesa-dev libx11-dev zlib1g-dev
RUN pip3 install --no-cache-dir lavavu

RUN git clone https://github.com/underworldcode/underworld2.git
WORKDIR $WORKSPACE/underworld2
RUN git checkout regionalMesh
WORKDIR $WORKSPACE/underworld2/libUnderworld
RUN ./configure.py --prefix=/underworld/install/directory
RUN ./compile.py
RUN ./scons.py install
RUN export PYTHONPATH=$PYTHONPATH:$WORKSPACE/underworld2
RUN export PYTHONPATH=$PYTHONPATH:$WORKSPACE/underworld2/libUnderworld/build/lib
WORKDIR $WORKSPACE

RUN pip3 install --no-cache-dir scipy
RUN pip3 install --no-cache-dir pandas
RUN pip3 install --no-cache-dir Pillow
RUN pip3 install --no-cache-dir bokeh
RUN pip3 install --no-cache-dir Flask
RUN pip3 install --no-cache-dir dask[complete]
RUN pip3 install --no-cache-dir scikit-learn
RUN pip3 install --no-cache-dir tensorflow