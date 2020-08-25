FROM ubuntu:18.04
MAINTAINER Fabien Wernli <altera@faxmodem.org>

ARG url=http://download.altera.com/akdlm/software/acdsinst/20.1std/711/ib_installers/QuartusProgrammerSetup-20.1.0.711-linux.run

ENTRYPOINT /usr/local/altera/qprogrammer/bin/quartus_pgmw

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install libfreetype6 libglib2.0-0 libsm6 libxrender1 libxft2 libxext6 wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
RUN wget $url -O /installer && \
	chmod +x /installer && \
	/installer --mode unattended --installdir /y --accept_eula 1 && \
	rm /installer && \
	mv /y /usr/local/altera

