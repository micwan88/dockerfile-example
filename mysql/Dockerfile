FROM ubuntu:18.04

ARG ROOTPASSWD
ENV MYSQLDIR /mysqlbase

LABEL maintainer="Michael Wan"

# check if ROOTPASSWD has been set or not and install mysql-server
RUN if [ -z ${ROOTPASSWD} ]; then echo "Does not have ROOTPASSWD !!"; exit 1; fi \
	&& apt-get update && apt-get install -y mysql-server \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean

# copy the mysql config
COPY mysqld.cnf /etc/mysql/mysql.conf.d/

# set and create work folder
WORKDIR ${MYSQLDIR}

# copy all scripts to work folder
COPY *.sh ${MYSQLDIR}/

# run script to init mysql db
RUN	./init-db-files.sh ${ROOTPASSWD}

# declare data is external mount
VOLUME ${MYSQLDIR}/data

# expose mysql port
EXPOSE 3306

# set docker image entry point
CMD ["./entry-point.sh"]
