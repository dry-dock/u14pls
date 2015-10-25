#!/bin/bash -e

echo "================= setting MySQL preReqs ==================="
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password aaa'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password aaa'

echo "=========== Downloading mysql 5.6 ==============="
cd /tmp && wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.23-debian6.0-x86_64.deb -O mysql-5.6.23-debian6.0-x86_64.deb;

echo "=========== Installing mysql 5.6 ==============="
dpkg -i  mysql-5.6.23-debian6.0-x86_64.deb;
rm mysql-5.6.23-debian6.0-x86_64.deb

echo "================= Configuring MySQL ==================="
chown -R mysql /opt/mysql/server-5.6/
chgrp -R mysql /opt/mysql/server-5.6/

ln -sf /opt/mysql/server-5.6/bin/mysqld_safe /usr/bin/mysqld_safe

sudo /usr/bin/mysqld_safe &
sleep 5
mysqladmin -u root -p'aaa' password ''
echo "GRANT ALL ON *.* TO shippable@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO travis@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO travis IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* TO ''@localhost IDENTIFIED BY ''; FLUSH PRIVILEGES;" | mysql -uroot
