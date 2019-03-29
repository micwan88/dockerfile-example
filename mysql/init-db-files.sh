#!/bin/bash

# set -v

ROOTPASSWD=$1
MYSQLDIR=/mysqlbase
MYSQL_LOGPATH=/var/log/mysql/error.log
MYSQL_DEBIAN_CFG_PATH=/etc/mysql/debian.cnf

echo "Trying to init mysql db files in ${MYSQLDIR} ..."

if [ -z ${ROOTPASSWD} ]; then
	echo "Please provide ROOT PASSWORD for mysql !!"
	echo "Usage: $0 ROOT_PASSWORD"
	exit 1
fi

mkdir -p ${MYSQLDIR}/data \
&& mysqld --initialize --user=mysql --basedir=${MYSQLDIR} --datadir=${MYSQLDIR}/data \
&& chown -R mysql:mysql ${MYSQLDIR} \
&& export RANDOMPW=`sed -n 's/.*temporary password is generated for root@localhost\: \(.*\)/\1/p' ${MYSQL_LOGPATH}` \
&& echo "Init Password: ${RANDOMPW}" \
&& export DEBIANPW=`sed -n 's/^password\s\=\s\(.*\)/\1/p' ${MYSQL_DEBIAN_CFG_PATH} | head -n 1` \
&& echo "Debian Sys Maint Password: ${DEBIANPW}" \
&& echo "SET PASSWORD FOR 'root'@'localhost' = '${ROOTPASSWD}';" > temp.sql \
&& echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOTPASSWD}' with grant option;" >> temp.sql \
&& echo "GRANT SHUTDOWN ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${DEBIANPW}';" >> temp.sql \
&& echo "Start mysql service to change root password ..." \
&& service mysql start \
&& mysql --connect-expired-password -u root -p${RANDOMPW} < temp.sql \
&& rm -rf temp.sql \
&& unset RANDOMPW \
&& unset DEBIANPW \
&& echo "Try to stop mysql service by using new password ..." \
&& mysqladmin -u root shutdown -p${ROOTPASSWD} \
&& rm -rf /var/log/mysql/error.log

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Init mysql db in ${MYSQLDIR} failed: ${RET}"
	exit 2
else
	echo "Initialize ${MYSQLDIR}/data completed."
fi