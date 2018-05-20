# dbproxy总结
## dbproxy部署搭建
- 机器初始化
``` bash 
wget https://raw.githubusercontent.com/mds1455975151/tools/master/shell/host_init.sh
sh host_init.sh
```
- MySQL环境
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/mysql/install_mysql.sh
sh install_mysql.sh
```

``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/supervisor/install_supervisor.sh
sh install_supervisor.sh
cat>/etc/supervisord.d/DBProxy.ini<<EOF
[program:DBProxy]
directory = /data0/dbproxy/infra-fp-mysql-dbproxy/DBProxy/
command = DBProxy DBProxy.conf
priority=1
numprocs=1
autostart=true
autorestart=true
stderr_logfile=/var/log/DBProxy_err.log
stdout_logfile=/var/log/DBProxy_out.log
EOF
systemctl restart supervisord.service
```
