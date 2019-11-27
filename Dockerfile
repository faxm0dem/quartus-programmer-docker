FROM ubuntu:18.04
MAINTAINER Fabien Wernli <altera@faxmodem.org>

ARG url=http://download.altera.com/akdlm/software/acdsinst/13.1/162/ib_installers/QuartusProgrammerSetup-13.1.0.162.run

ENTRYPOINT /usr/local/altera/qprogrammer/bin/quartus_pgmw

# Quartus 13 (and probably others) requires libpng12, which is not available anymore in Ubuntu 18.04
RUN echo "deb http://security.ubuntu.com/ubuntu xenial-security main" > /etc/apt/sources.list.d/xenial.list && \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libxft2:i386 libxext6:i386 libsm6:i386 libpng12-0:i386 libpng12-0 wget
RUN wget $url -O /installer
RUN chmod +x /installer
RUN yes | /installer
RUN rm /installer
RUN mv /y /usr/local/altera
RUN apt-get remove wget -y

# # Do you accept this license? [y/n]:
# ----------------------------------------------------------------------------
# Specify the directory where Quartus II Programmer and SignalTap II 13.1.0.162
# will be installed
# 
# Installation Directory [/root/altera/13.1]:
# ----------------------------------------------------------------------------
# Ready to Install
# 
# 
# 
# Summary:
#   Installation directory: /y
#   Required disk space:  937 MB
#   Available disk space: 126070 MB
# 
# 
# 
# 
# 
# 
# 
# ----------------------------------------------------------------------------
# Wait while Setup installs Quartus II Programmer and SignalTap II 13.1.0.162
# 
#  Installing
#  0% ______________ 50% ______________ 100%
#  #########################################
# 
# ----------------------------------------------------------------------------
# Setup has finished installing Quartus II Programmer and SignalTap II 13.1.0.162.
# 
# Launch Quartus II 13.1 Programmer [Y/n]:
# Launch Quartus II 13.1  SignalTap II [Y/n]:
# quartus_stpw: cannot connect to X server
# quartus_pgmw: cannot connect to X server

