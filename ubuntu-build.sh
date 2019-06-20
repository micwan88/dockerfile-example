#!/bin/bash

# set -v

WORKDIR=ubuntu
TAGNAME=micwan/ubuntu

cd ${WORKDIR}

echo "Start build ${TAGNAME} docker image ..."

docker build -t ${TAGNAME} .

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Build failed !!!"
	exit 2
fi

echo "Build Completed."