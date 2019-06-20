FROM ubuntu:18.04

ENV EXTDIR /downloads

LABEL maintainer="Michael Wan"

# install some common tools
RUN apt-get update && apt-get install -y net-tools openjdk-8-jdk \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean

# declare data is external mount
VOLUME ${EXTDIR}

# set docker image entry point
CMD ["/bin/bash]
