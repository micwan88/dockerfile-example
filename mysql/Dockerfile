FROM ubuntu:18.04

ARG ROOTPASSWD
ENV MYSQLDIR /mysqlbase

# check if ROOTPASSWD has been set or not and install mysql-server
RUN if [ -z ${ROOTPASSWD} ]; then echo "Does not have ROOTPASSWD !!"; exit 1; fi \
	&& apt-get update && apt-get install -y mysql-server \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean

# copy the mysql config
COPY mysqld.cnf /etc/mysql/mysql.conf.d/

WORKDIR ${MYSQLDIR}

# copy all scripts
COPY *.sh ${MYSQLDIR}/

RUN	./init-db-files.sh ${ROOTPASSWD}

VOLUME ${MYSQLDIR}/data

EXPOSE 3306

CMD ["./entry-point.sh"]
