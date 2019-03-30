#!/bin/bash

# set -v

WORKDIR=jupyter
TAGNAME=micwan/jupyter

cd ${WORKDIR}

echo "Start build jupyter docker image ..."

docker build -t ${TAGNAME} .

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Build failed !!!"
	exit 2
fi

echo "Build Completed."