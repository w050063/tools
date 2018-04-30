#!/bin/env bash 

wget https://raw.githubusercontent.com/mds1455975151/tools/master/shell/host_init.sh
sh host_init.sh
wget https://raw.githubusercontent.com/mds1455975151/tools/master/go/go_install.sh
sh go_install.sh
wget https://github.com/mds1455975151/tools/blob/master/mysql/install_mysql.sh
sh install_mysql.sh
yum install -y make automake libtool python-devel python-virtualenv MySQL-python openssl-devel gcc-c++ git pkg-config bison curl unzip
yum install -y java-1.7.0-openjdk
useradd vitess
cd $GOPATH
git clone https://github.com/vitessio/vitess.git src/vitess.io/vitess
cd src/vitess.io/vitess
export MYSQL_FLAVOR=MySQL56
./bootstrap.sh
//开始编译环境准备
