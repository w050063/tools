# start cluster
``` bash
# export VTROOT=$GOPATH
# export VTDATAROOT=$GOPATH/vtdataroot
# export MYSQL_FLAVOR=MySQL56
# export VT_MYSQL_ROOT=/usr

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
# ./vttablet-up.sh 
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
E0501 09:29:00.906744   81118 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000103/mysql.sock
E0501 09:29:00.906760   81119 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000104/mysql.sock
E0501 09:29:00.907342   81117 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000102/mysql.sock
E0501 09:29:00.907572   81115 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000100/mysql.sock
E0501 09:29:00.937445   81116 mysqlctl.go:260] failed start mysql: deadline exceeded waiting for mysqld socket file to appear: /data0/workspaces/go/vtdataroot/vt_0000000101/mysql.sock
Starting vttablet for test-0000000100...
Access tablet test-0000000100 at http://192.168.47.100:15100/debug/status
Starting vttablet for test-0000000101...
Access tablet test-0000000101 at http://192.168.47.100:15101/debug/status
Starting vttablet for test-0000000102...
Access tablet test-0000000102 at http://192.168.47.100:15102/debug/status
Starting vttablet for test-0000000103...
Access tablet test-0000000103 at http://192.168.47.100:15103/debug/status
Starting vttablet for test-0000000104...
Access tablet test-0000000104 at http://192.168.47.100:15104/debug/status

报错信息1：
E0501 09:10:01.517581   71126 mysqld.go:605] mysql_install_db failed: /bin/mysql_install_db: exit status 1, output: WARNING: Could not write to config file //my.cnf: 权限不够

FATAL ERROR: Could not find /fill_help_tables.sql

If you compiled from source, you need to run 'make install' to
copy the software into the correct location ready for operation.

If you are using a binary release, you must either be at the top
level of the extracted archive, or pass the --basedir option
pointing to that location.


MySQL报错信息
180501 09:13:48 mysqld_safe Logging to '/data0/workspaces/go/vtdataroot/vt_0000000100/error.log'.
180501 09:13:48 mysqld_safe Starting mysqld daemon with databases from /data0/workspaces/go/vtdataroot/vt_0000000100/data
2018-05-01 09:13:48 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
2018-05-01 09:13:48 0 [Note] //sbin/mysqld (mysqld 5.6.40-log) starting as process 80405 ...
2018-05-01 09:13:48 80405 [ERROR] Can't find messagefile '/share/mysql/errmsg.sys'
2018-05-01 09:13:48 80405 [Warning] Buffered warning: Changed limits: max_open_files: 1024 (requested 5000)

2018-05-01 09:13:48 80405 [Warning] Buffered warning: Changed limits: table_open_cache: 457 (requested 2048)

2018-05-01 09:13:48 80405 [Note] Plugin 'FEDERATED' is disabled.
//sbin/mysqld: Unknown error 1146
2018-05-01 09:13:48 80405 [ERROR] Can't open the mysql.plugin table. Please run mysql_upgrade to create it.
2018-05-01 09:13:48 80405 [Note] InnoDB: Using atomics to ref count buffer pool pages
2018-05-01 09:13:48 80405 [Note] InnoDB: The InnoDB memory heap is disabled
2018-05-01 09:13:48 80405 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
2018-05-01 09:13:48 80405 [Note] InnoDB: Memory barrier is not used
2018-05-01 09:13:48 80405 [Note] InnoDB: Compressed tables use zlib 1.2.3
2018-05-01 09:13:48 80405 [Note] InnoDB: Using CPU crc32 instructions
2018-05-01 09:13:48 80405 [Note] InnoDB: Initializing buffer pool, size = 32.0M
2018-05-01 09:13:48 80405 [Note] InnoDB: Completed initialization of buffer pool
2018-05-01 09:13:48 80405 [Note] InnoDB: Highest supported file format is Barracuda.
2018-05-01 09:13:49 80405 [Note] InnoDB: 128 rollback segment(s) are active.
2018-05-01 09:13:49 80405 [Note] InnoDB: Waiting for purge to start
2018-05-01 09:13:49 80405 [Note] InnoDB: 5.6.40 started; log sequence number 1600566
2018-05-01 09:13:49 80405 [ERROR] Aborting

2018-05-01 09:13:49 80405 [Note] Binlog end
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'rpl_semi_sync_slave'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'rpl_semi_sync_master'
2018-05-01 09:13:49 80405 [Note] unregister_replicator OK
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'partition'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_DELETED'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_METRICS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMPMEM'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMP_RESET'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_CMP'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_LOCKS'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'INNODB_TRX'
2018-05-01 09:13:49 80405 [Note] Shutting down plugin 'InnoDB'
2018-05-01 09:13:49 80405 [Note] InnoDB: FTS optimize thread exiting.
2018-05-01 09:13:49 80405 [Note] InnoDB: Starting shutdown...
2018-05-01 09:13:50 80405 [Note] InnoDB: Shutdown completed; log sequence number 1600576
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'BLACKHOLE'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'ARCHIVE'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'MRG_MYISAM'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'MyISAM'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'MEMORY'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'CSV'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'sha256_password'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'mysql_old_password'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'mysql_native_password'
2018-05-01 09:13:50 80405 [Note] Shutting down plugin 'binlog'
2018-05-01 09:13:50 80405 [Note] 
180501 09:13:50 mysqld_safe mysqld from pid file /data0/workspaces/go/vtdataroot/vt_0000000100/mysql.pid ended

使用软链接暂时修复该问题
ln -s /usr/share /share
```
