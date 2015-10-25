#!/bin/bash -e

. $HOME/.bashrc

for file in /tmp/version/*;
do
  . $file
done

echo "================= Adding mysql cnf ==================="
cp my.cnf /etc/mysql/my.cnf

echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
