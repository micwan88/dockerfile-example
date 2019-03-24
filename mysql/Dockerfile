FROM ubuntu:18.04

ARG ROOTPASSWD
ENV MYSQLDIR /mysqlbase

# check if ROOTPASSWD has been set or not
RUN if [ -z ${ROOTPASSWD} ]; then echo "Does not have ROOTPASSWD !!"; exit 1; fi

# install mysql and set it data dir
RUN apt-get update && apt-get install -y mysql-server && \
	mkdir -p ${MYSQLDIR}/data && \
	mysqld --initialize --user=mysql --basedir=${MYSQLDIR} --datadir=${MYSQLDIR}/data

# copy the mysql config
COPY mysqld.cnf /etc/mysql/mysql.conf.d/

# start mysql service and change root password
RUN chown -R mysql:mysql ${MYSQLDIR}
#	service mysql start
# RUN mysqladmin -u root password '${ROOTPASSWD}'

EXPOSE 3306
