# DBProxyMgr
```
cd /data0/dbproxy/infra-fp-mysql-dbproxy/DBProxyMgr
make    # 复制DBProxy代码，编译，复制配置

wget https://raw.githubusercontent.com/mds1455975151/tools/master/supervisor/install_supervisor.sh
sh install_supervisor.sh

cat>/etc/supervisord.d/DBProxyMgr.ini<<EOF
[program:DBProxyMgr]
directory = /data0/dbproxy/infra-fp-mysql-dbproxy/DBProxyMgr/DBPM
command = /data0/dbproxy/infra-fp-mysql-dbproxy/DBProxyMgr/DBPM/DBProxyMgr DBProxy.conf
priority=1
numprocs=1
autostart=true
autorestart=true
stderr_logfile=/var/log/DBProxyMgr_err.log
stdout_logfile=/var/log/DBProxyMgr_out.log
EOF
systemctl restart supervisord.service
```
