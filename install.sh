#!/bin/bash -e

mkdir -p /tmp
chmod 1777 /tmp

for file in /u14pls/version/*;
do
  . $file
done

echo "================= Adding mysql cnf ==================="
cd /u14pls && cp -rf my.cnf /etc/mysql/my.cnf

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
