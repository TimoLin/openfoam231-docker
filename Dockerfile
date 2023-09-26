FROM ubuntu:18.04

RUN apt-get update && apt-get install -y apt-utils

# Install building environment prerequisites
RUN apt-get install -y build-essential make cmake flex bison zlib1g-dev gnuplot \
        libreadline-dev libncurses5-dev libxt-dev libopenmpi-dev openmpi-bin libboost-system-dev libboost-thread-dev libgmp-dev \
        libmpfr-dev libcgal-dev gcc-5 g++-5

# Install tools
RUN apt-get install -y vim sudo git wget zsh

# Install oh-my-zsh
#Run git clone https://ghproxy.com/https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
#RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
#RUN echo "source /root/.zshrc" >> /etc/zsh/zshrc

# set alias of the openfoam-2.3.1 environment
RUN echo "alias of231='source ~/OpenFOAM/of-env.bashrc'" >> /etc/zsh/zshrc
