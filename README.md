# Welcome to dockerfile-example

This repository is for the author (`Michael Wan`) to store his Dockerfile.

## Contribution
This repository is created for my own interest but it is welcome for anyone to fork or contribute.

## Dockerfile Example
Below are list of Dockerfile in the repositry
1. Ubuntu
2. MySQL

## Build Docker Image

- For Ubuntu

``` bash
./ubuntu-build.sh
```

- For MySQL

``` bash
#Please replace <ROOT)PASSWORD> with the actual password you want.
./mysql-build.sh <ROOT_PASSWORD>
```

## Individual Commands For The Image 

- MySQL (Initialize MySQL database in external directory)

The MySQL dockerfile aims to mount the database externally and so we can use below command to initial the MySQL database with docker command.

``` bash
#Please replace `<ROOT_PASSWORD>` with actual MySQL root password you want.
docker run -it -v /external/dir:/mysqlbase/data -p 3306:3306 micwan/mysql /mysqlbase/init-db-files.sh <ROOT_PASSWORD>
```

- MySQL (Launch MySQL client `mysql`)

``` bash
docker exec -it <CONTAINER_ID or CONTAINER_NAME> mysql -p
```
