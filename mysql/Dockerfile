FROM ubuntu:18.04

ARG ROOTPASSWD
ENV MYSQLDIR /mysqlbase

# check if ROOTPASSWD has been set or not and install mysql-server
RUN if [ -z ${ROOTPASSWD} ]; then echo "Does not have ROOTPASSWD !!"; exit 1; fi \
	&& apt-get update && apt-get install -y mysql-server \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p ${MYSQLDIR}/data \
	&& mysqld --initialize --user=mysql --basedir=${MYSQLDIR} --datadir=${MYSQLDIR}/data \
	&& chown -R mysql:mysql ${MYSQLDIR} \
	&& export RANDOMPW=`sed -n 's/.*temporary password is generated for root@localhost\: \(.*\)/\1/p' /var/log/mysql/error.log` \
	&& echo "Generated password: ${RANDOMPW}"
	
	# && service mysql start \
	# && mysqladmin -u root password '${ROOTPASSWD}' -p${RANDOMPW} \
	# && unset RANDOMPW
	# && service mysql stop \
	# && rm -rf /var/log/mysql/error.log

# copy the mysql config
COPY mysqld.cnf /etc/mysql/mysql.conf.d/

EXPOSE 3306
