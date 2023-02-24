FROM ubuntu:22.04

ENV EXTDIR=/media

LABEL maintainer="Michael Wan"

# declare data is external volume
VOLUME ${EXTDIR}

# init directories it if not exist
RUN mkdir -p ${EXTDIR}

# set working directory
WORKDIR ${EXTDIR}

# install some common tools
RUN apt-get update && apt-get install -y locales net-tools iputils-ping unzip git wget curl vim software-properties-common \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set timezone noninteractive
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# set docker image entry point
CMD ["/bin/bash"]
