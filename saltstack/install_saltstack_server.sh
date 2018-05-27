#!/bin/bash

. /etc/init.d/functions

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'

# epel and aliyun yum install
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo 

# saltstack master install
yum -y install salt-master salt-api

cp /etc/salt/master{,.`date +%Y%m%d`}

#绑定master通信IP 云主机外网IP地址需手动绑定
ip=`ifconfig eth0|awk -F '[ :]+' '/inet addr/{print $4}'`
sed -i "s/#interface: 0.0.0.0/interface: ${ip}/g" /etc/salt/master

#设置自动认证
sed -i 's/#auto_accept: False/auto_accept: Ture/p' /etc/salt/master

#指定saltstack文件根目录位置
sed -i '416,418s/#//g' /etc/salt/master

# saltstack start setup
/etc/init.d/salt-master start
chkconfig salt-master on
