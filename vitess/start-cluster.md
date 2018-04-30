# start cluster
``` bash
# export VTROOT=$GOPATH
# export VTDATAROOT=$GOPATH/vtdataroot

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
//未启动 排查错误日志目录：/data0/workspaces/go/vtdataroot

```
