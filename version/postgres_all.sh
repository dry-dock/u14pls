#!/bin/bash -e

sudo apt-get install -y wget ca-certificates

echo "================= Installing Postgre ==================="
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.4 postgresql-9.3 postgresql-9.2 postgresql-9.1 postgresql-9.4-postgis-2.1 postgresql-9.3-postgis-2.1 postgresql-9.2-postgis-2.1 postgresql-9.1-postgis-2.1
