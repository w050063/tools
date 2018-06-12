# DBProxyMgr
```
cd /data0/dbproxy/infra-fp-mysql-dbproxy/DBProxyMgr
make    # 复制DBProxy代码，编译，复制配置
sed -i 's/FPNN.server.listening.port = 12321/FPNN.server.listening.port = 12322/g' DBProxy.conf
sed -n '/FPNN.server.listening.port/p' DBProxy.conf

vim DBProxy.conf    # 新增配置项 确保大批量更新时不会超时
FPNN.server.idle.timeout = 1800

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
supervisorctl status
netstat -tunlp|grep 12322
```
# 修改表结构
``` bash
cd /data0/dbproxy/infra-fp-mysql-dbproxy/tools
./DBParamsQuery -h
Usage: 
        ./DBParamsQuery [-h host] [-p port] [-t table_name] [-timeout timeout_seconds] <hintId | -i int_hintIds | -s string_hintIds> sql [param1 param2 ...]

        Notes: host default is localhost, and port default is 12321.
```
