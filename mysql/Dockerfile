FROM ubuntu:18.04

ARG ROOTPASSWD
ENV MYSQLDIR /mysqlbase

# check if ROOTPASSWD has been set or not and install mysql-server
RUN if [ -z ${ROOTPASSWD} ]; then echo "Does not have ROOTPASSWD !!"; exit 1; fi && \
	apt-get update && apt-get install -y mysql-server

# copy the mysql config
COPY mysqld.cnf /etc/mysql/mysql.conf.d/

# init mysql db, start mysql service and change root password
RUN mkdir -p ${MYSQLDIR}/data && \
	mysqld --initialize --user=mysql --basedir=${MYSQLDIR} --datadir=${MYSQLDIR}/data && \
	chown -R mysql:mysql ${MYSQLDIR} && \
	export RANDOMPW=`sed -n 's/.*temporary password is generated for root@localhost\: \(.*\)/\1/p' /var/log/mysql/error.log` && \
	echo "Random password: ${RANDOMPW}" && \
	service mysql start && \
	mysqladmin -u root password '${ROOTPASSWD}' -p${RANDOMPW} && \
	unset RANDOMPW
	#service mysql stop && \
	#rm -rf /var/log/mysql/error.log

EXPOSE 3306
