#!/bin/bash -e

mkdir -p /tmp
chmod 1777 /tmp

for file in /u14pls/version/*;
do
  . $file
done

echo "================= Adding mysql cnf ==================="
cd /u14pls && cp -rf my.cnf /etc/mysql/my.cnf

echo "================= Adding PostgreSQL cnf ==================="
cd /u14pls && cp -rf pg_hba.cnf /etc/postgresql/9.4/main/pg_hba.conf

echo "================= Add memcached cnf ======================="
cd /u14pls && cp -rf memcached.cnf /etc/memcached.conf

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
