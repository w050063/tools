#!/bin/env bash

data_dir="/data0/src"
repo_version="mysql57-community-release-el7-11.noarch.rpm"
repo_version="mysql57-community-release-el7-10.noarch.rpm"

[ ! -d ${data_dir} ] && mkdir -p ${data_dir}

if [ ! -f ${data_dir}/${repo_version} ]
then
    # wget -O ${data_dir}/${repo_version} https://repo.mysql.com/${repo_version}
    wget -O ${data_dir}/${repo_version} https://mirrors.tuna.tsinghua.edu.cn/mysql/yum/mysql57-community-el7/${repo_version}
fi

rpm -ivh ${data_dir}/${repo_version}

yum repolist all | grep mysql
yum install -y yum-utils
yum-config-manager --disable mysql57-community >/dev/null 2>&1
yum-config-manager --enable mysql56-community >/dev/null 2>&1
yum repolist enabled | grep mysql

yum install -y mysql-community-server mysql-community-devel
wget -O /etc/my.cnf https://raw.githubusercontent.com/mds1455975151/tools/master/db/mysql/my.cnf
systemctl start mysqld.service
systemctl status mysqld.service

wget -O ${data_dir}/mysql.sql https://raw.githubusercontent.com/mds1455975151/tools/master/db/mysql/mysql.sql
# mysql_upgrade -uroot -p123456
mysql_upgrade
mysql -uroot < ${data_dir}/mysql.sql
mysql -uroot -p123456 -h 127.0.0.1 -e "select user,host,password from mysql.user;"
mysql -uroot -p123456 -h 127.0.0.1 -e "select version();"
