#!/bin/bash -e

echo "================= setting MySQL preReqs ==================="
sudo groupadd mysql
sudo useradd -g mysql mysql
apt-get install libaio1
mkdir -p /tmp
chmod 1777 /tmp
mkdir -p /etc/mysql

echo "=========== Downloading mysql 5.6 ==============="
cd /usr/local
wget -O mysql-5.6.26-linux-glibc2.5-x86_64.tar.gz https://downloads.mariadb.com/archives/mysql-5.6/mysql-5.6.26-linux-glibc2.5-x86_64.tar.gz
tar xvfz mysql-5.6.26-linux-glibc2.5-x86_64.tar.gz
mv mysql-5.6.26-linux-glibc2.5-x86_64 mysql
rm mysql-5.6.26-linux-glibc2.5-x86_64.tar.gz
cd mysql
chown -R mysql .
chgrp -R mysql .

echo "================= Configuring MySQL ==================="
scripts/mysql_install_db --user=mysql
chown -R root .
chown -R mysql data
cp support-files/mysql.server /etc/init.d/mysql.server
cp -rf my.cnf /usr/local/mysql/my.cnf

echo "=========== Installing mysql clients 5.6 ==============="
apt-get install mysql-client-5.6
