FROM ubuntu:12.04

RUN apt-get update && apt-get install -y wget
RUN sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add - && echo deb http://dl.openfoam.org/ubuntu precise main > /etc/apt/sources.list.d/openfoam.list"
RUN apt-get update && apt-get install -y openfoam222 paraviewopenfoam410
RUN apt-get install -y nano sudo git mc gnuplot tmux make
