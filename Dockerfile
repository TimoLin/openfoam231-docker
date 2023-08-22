FROM ubuntu:18.04

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y build-essential make cmake flex bison zlib1g-dev gnuplot \
        libreadline-dev libncurses5-dev libxt-dev libopenmpi-dev openmpi-bin libboost-system-dev libboost-thread-dev libgmp-dev \
        libmpfr-dev libcgal-dev gcc-5 g++-5
RUN apt-get install -y vim sudo git wget
