#!/bin/bash

# set -v

MYSQLLOG=/var/log/mysql/error.log

echo "Start mysql service ..."

service mysql start

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Cannot start mysql service"
	exit 1
fi

tail -n 500 -f ${MYSQLLOG}

echo "Stop mysql service ..."
service mysql stop

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Cannot stop mysql service"
	exit 2
fi

echo "Done"