# start cluster
``` bash
# export VTROOT=$GOPATH
# export VTDATAROOT=$GOPATH/vtdataroot
# export MYSQL_FLAVOR=MySQL56

// 普通用户添加到root组
# usermod vitess -G root

# mkdir -p /data0/workspaces/go/vtdataroot
# cd $VTROOT/src/vitess.io/vitess/examples/local
# ./zk-up.sh 
enter zk2 env
Starting zk servers...
Waiting for zk servers to be ready...
Started zk servers.
Configured zk servers.
# ps -ef|grep zk
root      55694      1  0 15:24 pts/1    00:00:00 /bin/bash /data0/workspaces/go/bin/zksrv.sh /data0/workspaces/go/vtdataroot/zk_001/logs /data0/workspaces/go/vtdataroot/zk_001/zoo.cfg /data0/workspaces/go/vtdataroot/zk_001/zk.pid
root      55695      1  0 15:24 pts/1    00:00:00 /bin/bash /data0/workspaces/go/bin/zksrv.sh /data0/workspaces/go/vtdataroot/zk_002/logs /data0/workspaces/go/vtdataroot/zk_002/zoo.cfg /data0/workspaces/go/vtdataroot/zk_002/zk.pid
root      55697      1  0 15:24 pts/1    00:00:00 /bin/bash /data0/workspaces/go/bin/zksrv.sh /data0/workspaces/go/vtdataroot/zk_003/logs /data0/workspaces/go/vtdataroot/zk_003/zoo.cfg /data0/workspaces/go/vtdataroot/zk_003/zk.pid
root      55706  55697  9 15:24 pts/1    00:00:00 java -server -DZOO_LOG_DIR=/data0/workspaces/go/vtdataroot/zk_003/logs -cp /data0/workspaces/go/dist/vt-zookeeper-3.4.10/lib/zookeeper-3.4.10-fatjar.jar:/usr/local/lib/zookeeper-3.4.10-fatjar.jar:/usr/share/java/zookeeper-3.4.10.jar org.apache.zookeeper.server.quorum.QuorumPeerMain /data0/workspaces/go/vtdataroot/zk_003/zoo.cfg
root      55708  55695  9 15:24 pts/1    00:00:00 java -server -DZOO_LOG_DIR=/data0/workspaces/go/vtdataroot/zk_002/logs -cp /data0/workspaces/go/dist/vt-zookeeper-3.4.10/lib/zookeeper-3.4.10-fatjar.jar:/usr/local/lib/zookeeper-3.4.10-fatjar.jar:/usr/share/java/zookeeper-3.4.10.jar org.apache.zookeeper.server.quorum.QuorumPeerMain /data0/workspaces/go/vtdataroot/zk_002/zoo.cfg
root      55711  55694  9 15:24 pts/1    00:00:00 java -server -DZOO_LOG_DIR=/data0/workspaces/go/vtdataroot/zk_001/logs -cp /data0/workspaces/go/dist/vt-zookeeper-3.4.10/lib/zookeeper-3.4.10-fatjar.jar:/usr/local/lib/zookeeper-3.4.10-fatjar.jar:/usr/share/java/zookeeper-3.4.10.jar org.apache.zookeeper.server.quorum.QuorumPeerMain /data0/workspaces/go/vtdataroot/zk_001/zoo.cfg
root      55834   1624  0 15:24 pts/1    00:00:00 grep --color=auto zk
# ./vtctld-up.sh 
enter zk2 env
Starting vtctld...
Access vtctld web UI at http://linux-node01:15000
Send commands with: vtctlclient -server linux-node01:15999 ...
//未启动 排查错误日志目录：/data0/workspaces/go/vtdataroot  使用普通用户启动
#  ./vttablet-up.sh   
enter zk2 env
Starting MySQL for tablet test-0000000100...
Resuming from existing vttablet dir:
    /data0/workspaces/go/vtdataroot/vt_0000000100
Starting MySQL for tablet test-0000000101...
Resuming from existing vttablet dir:
    /data0/workspaces/go/vtdataroot/vt_0000000101
Starting MySQL for tablet test-0000000102...
Resuming from existing vttablet dir:
    /data0/workspaces/go/vtdataroot/vt_0000000102
Starting MySQL for tablet test-0000000103...
Resuming from existing vttablet dir:
    /data0/workspaces/go/vtdataroot/vt_0000000103
Starting MySQL for tablet test-0000000104...
Resuming from existing vttablet dir:
    /data0/workspaces/go/vtdataroot/vt_0000000104

报错信息1：
E0501 09:10:01.517581   71126 mysqld.go:605] mysql_install_db failed: /bin/mysql_install_db: exit status 1, output: WARNING: Could not write to config file //my.cnf: 权限不够

FATAL ERROR: Could not find /fill_help_tables.sql

If you compiled from source, you need to run 'make install' to
copy the software into the correct location ready for operation.

If you are using a binary release, you must either be at the top
level of the extracted archive, or pass the --basedir option
pointing to that location.

报错信息2：
E0501 09:10:17.646974   66514 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000101/mysql.sock
E0501 09:10:17.822627   66517 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000104/mysql.sock
E0501 09:10:17.822773   66516 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000103/mysql.sock
E0501 09:10:17.823468   66515 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000102/mysql.sock
E0501 09:10:18.054757   66513 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000100/mysql.sock
```
