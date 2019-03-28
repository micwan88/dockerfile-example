#!/bin/bash

# set -v

WORKDIR=mysql
TAGNAME=micwan/mysql
ROOTPASSWD=$1

if [ -z ${ROOTPASSWD} ]; then
	echo "Does not have mysql ROOT PASSWORD !!"
	exit 1
fi

cd ${WORKDIR}

echo "Start build mysql docker image ..."

docker build -t ${TAGNAME} --build-arg ROOTPASSWD=${ROOTPASSWD} .

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Build failed !!!"
	exit 2
fi

echo "Build Completed."