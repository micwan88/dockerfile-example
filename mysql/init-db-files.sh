#!/bin/bash

# set -v

ROOTPASSWD=$1
MYSQLDIR=/mysqlbase

echo "Trying to init mysql db files in ${MYSQLDIR} ..."

if [ -z ${ROOTPASSWD} ]; then
	echo "Does not have ROOTPASSWD !!"
	exit 1
fi

mkdir -p ${MYSQLDIR}/data \
&& mysqld --initialize --user=mysql --basedir=${MYSQLDIR} --datadir=${MYSQLDIR}/data \
&& chown -R mysql:mysql ${MYSQLDIR} \
&& export RANDOMPW=`sed -n 's/.*temporary password is generated for root@localhost\: \(.*\)/\1/p' /var/log/mysql/error.log` \
&& echo "Generated password: ${RANDOMPW}" \
&& export DEBIANPW=`sed -n 's/^password\s\=\s\(.*\)/\1/p' /etc/mysql/debian.cnf | head -n 1` \
&& echo "Debian sys maint password: ${DEBIANPW}" \
&& echo "SET PASSWORD FOR 'root'@'localhost' = '${ROOTPASSWD}';" > temp.sql \
&& echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOTPASSWD}' with grant option;" >> temp.sql \
&& echo "GRANT SHUTDOWN ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${DEBIANPW}';" >> temp.sql \
&& echo "Start mysql service to load root password ..." \
&& service mysql start \
&& mysql --connect-expired-password -u root -p${RANDOMPW} < temp.sql \
&& rm -rf temp.sql \
&& unset RANDOMPW \
&& unset DEBIANPW \
&& echo "Stop mysql service via new password ..." \
&& mysqladmin -u root shutdown -p${ROOTPASSWD} \
&& rm -rf /var/log/mysql/error.log

RET=$?

if [ ${RET} -ne 0 ]; then
	echo "Error: ${RET}"
	exit 2
else
	echo "Done"
fi