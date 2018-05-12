# Demo 演示
本节示例显示里使用etcd集群的基本过程。

# Set up a cluster	设置一个集群
在每个etcd节点上，指定集群成员：
``` bash
TOKEN=token-01
CLUSTER_STATE=new
NAME_1=machine-1
NAME_2=machine-2
NAME_3=machine-3
HOST_1=192.168.200.117
HOST_2=192.168.200.108
HOST_3=192.168.200.109
CLUSTER=${NAME_1}=http://${HOST_1}:2380,${NAME_2}=http://${HOST_2}:2380,${NAME_3}=http://${HOST_3}:2380
```

在每台机器上运行：
``` bash
# For machine 1
THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}
```

# For machine 2
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 3
THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

连接etcd
export ETCDCTL_API=3
HOST_1=192.168.200.117
HOST_2=192.168.200.108
HOST_3=192.168.200.109
ENDPOINTS=$HOST_1:2379,$HOST_2:2379,$HOST_3:2379

# etcdctl --endpoints=$ENDPOINTS member list
4655a0343baa19a2, started, machine-1, http://192.168.200.117:2380, http://192.168.200.117:2379
ae14786daacedb8c, started, machine-2, http://192.168.200.108:2380, http://192.168.200.108:2379
e2d7f969a0f9541b, started, machine-3, http://192.168.200.109:2380, http://192.168.200.109:2379

Access etcd	访问etcd（失败）
put 命令写：
etcdctl --endpoints=$ENDPOINTS put foo "Hello World!"
get 从etcd读取：
etcdctl --endpoints=$ENDPOINTS get foo
etcdctl --endpoints=$ENDPOINTS --write-out="json" get foo

Get by prefix	获取前缀
etcdctl --endpoints=$ENDPOINTS put web1 value1
etcdctl --endpoints=$ENDPOINTS put web2 value2
etcdctl --endpoints=$ENDPOINTS put web3 value3

etcdctl --endpoints=$ENDPOINTS get web --prefix

Delete	删除
etcdctl --endpoints=$ENDPOINTS put key myvalue
etcdctl --endpoints=$ENDPOINTS del key

etcdctl --endpoints=$ENDPOINTS put k1 value1
etcdctl --endpoints=$ENDPOINTS put k2 value2
etcdctl --endpoints=$ENDPOINTS del k --prefix

Transactional write	 事务写(失败)
etcdctl --endpoints=$ENDPOINTS put user1 bad
etcdctl --endpoints=$ENDPOINTS txn --interactive

compares:
value("user1") = "bad"

success requests (get, put, delete):
del user1

failure requests (get, put, delete):
put user1 good

Watch	看
Lease	租
Distributed locks	分布式锁
Elections	选举
Cluster status	集群状态
# etcdctl --write-out=table --endpoints=$ENDPOINTS endpoint status
+-------------------------------+----------------------------+---------------+-----------+---------------+----------------+-----------------+
|       ENDPOINT    |        ID        | VERSION | DB SIZE | IS LEADER | RAFT TERM | RAFT INDEX |
+-------------------------------+----------------------------+---------------+-----------+---------------+----------------+-----------------+
| 192.168.200.117:2379 | 4655a0343baa19a2 |   3.2.9 |   25 kB |      true |        14 |         27 |
| 192.168.200.108:2379 | ae14786daacedb8c |   3.2.9 |   25 kB |     false |        14 |         27 |
| 192.168.200.109:2379 | e2d7f969a0f9541b |   3.2.9 |   25 kB |     false |        14 |         27 |
+-------------------------------+----------------------------+---------------+-----------+---------------+----------------+------------------+
# etcdctl --endpoints=$ENDPOINTS endpoint health
192.168.200.109:2379 is healthy: successfully committed proposal: took = 5.230173ms
192.168.200.117:2379 is healthy: successfully committed proposal: took = 4.87ms
192.168.200.108:2379 is healthy: successfully committed proposal: took = 4.385116ms

Snapshot	快照
# etcdctl --endpoints=$ENDPOINTS snapshot save my.db
Snapshot saved at my.db
# etcdctl --write-out=table --endpoints=$ENDPOINTS snapshot status my.db
+----------+----------+------------+------------+
|   HASH   | REVISION | TOTAL KEYS | TOTAL SIZE |
+----------+----------+------------+------------+
| 17218edf |       13 |         19 |      25 kB |
+----------+----------+------------+------------+
Migrate	迁移
Member	成员
Auth认证
