#!/bin/bash -e

mkdir -p /tmp
chmod 1777 /tmp

for file in /u14pls/version/*;
do
  . $file
done

echo "================= Adding mysql cnf ==================="
cd /u14pls/config/mysql && cp -rf my.cnf /etc/mysql/my.cnf

echo "================= Adding PostgreSQL cnf ==================="
cd /u14pls/config/postgres && cp -rf pg_hba-9.1.conf /etc/postgresql/9.1/main/pg_hba.conf
cd /u14pls/config/postgres && cp -rf pg_hba-9.2.conf /etc/postgresql/9.2/main/pg_hba.conf
cd /u14pls/config/postgres && cp -rf pg_hba-9.3.conf /etc/postgresql/9.3/main/pg_hba.conf
cd /u14pls/config/postgres && cp -rf pg_hba-9.4.conf /etc/postgresql/9.4/main/pg_hba.conf
cd /u14pls/config/postgres && cp -rf postgresql-9.1.conf /etc/postgresql/9.1/main/postgresql.conf
cd /u14pls/config/postgres && cp -rf postgresql-9.2.conf /etc/postgresql/9.2/main/postgresql.conf
cd /u14pls/config/postgres && cp -rf postgresql-9.3.conf /etc/postgresql/9.3/main/postgresql.conf
cd /u14pls/config/postgres && cp -rf postgresql-9.4.conf /etc/postgresql/9.4/main/postgresql.conf

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
