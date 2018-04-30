#!/bin/env bash

yum install -y autoconf automake libtool
git clone https://github.com/twitter/twemproxy.git
cd twemproxy/
git checkout -b v0.4.1
git branch -a
CFLAGS="-ggdb3 -O0"
autoreconf -fvi
./configure --enable-debug=log
# ./configure --enable-debug=full
make
src/nutcracker -h
cd src/ && install nutcracker /usr/bin/
cp ../conf/nutcracker.yml /etc/nutcracker.yml
vim /etc/nutcracker.yml 
nutcracker -c /etc/nutcracker.yml
yum install -y redis
systemctl enable redis
systemctl start redis
nutcracker -c /etc/nutcracker.yml 

wget https://raw.githubusercontent.com/mds1455975151/tools/master/supervisor/install_supervisor.sh
sh install_supervisor.sh
cat>/etc/supervisord.d/nutcracker.ini<<EOF
[program:nutcracker]  
directory = /usr/bin/ 
command = /usr/bin/nutcracker -c /etc/nutcracker.yml
priority=1  
numprocs=1  
autostart=true  
autorestart=true
stderr_logfile=/var/log/nutcracker_err.log  
stdout_logfile=/var/log/nutcracker_out.log 
EOF

