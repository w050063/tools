
2.1 Consul基本使用
下载页面：https://www.consul.io/downloads.html
# 安装Consul
```
[root@linux-node1 local]# unzip consul_0.8.5_linux_amd64.zip
Archive:  consul_0.8.5_linux_amd64.zip
  inflating: consul
[root@linux-node1 local]# mv consul /usr/bin/
[root@linux-node1 local]# consul –help
```

# 单节点启动Consul
```
[root@linux-node1 local]# consul agent -dev
==> Starting Consul agent...
==> Consul agent running!
           Version: 'v0.8.5'
           Node ID: '86b74e66-9e22-12d3-139a-1a090ab2a041'
         Node name: 'linux-node1'
        Datacenter: 'dc1'
            Server: true (bootstrap: false)
       Client Addr: 127.0.0.1 (HTTP: 8500, HTTPS: -1, DNS: 8600)
      Cluster Addr: 127.0.0.1 (LAN: 8301, WAN: 8302)
    Gossip encrypt: false, RPC-TLS: false, TLS-Incoming: false

==> Log data will now stream in as it occurs:

    2017/07/19 16:36:48 [DEBUG] Using random ID "86b74e66-9e22-12d3-139a-1a090ab2a041" as node ID
    2017/07/19 16:36:48 [INFO] raft: Initial configuration (index=1): [{Suffrage:Voter ID:127.0.0.1:8300 Address:127.0.0.1:8300}]
    2017/07/19 16:36:48 [INFO] serf: EventMemberJoin: linux-node1 127.0.0.1
    2017/07/19 16:36:48 [INFO] serf: EventMemberJoin: linux-node1.dc1 127.0.0.1
    2017/07/19 16:36:48 [INFO] agent: Started DNS server 127.0.0.1:8600 (udp)
    2017/07/19 16:36:48 [INFO] raft: Node at 127.0.0.1:8300 [Follower] entering Follower state (Leader: "")
    2017/07/19 16:36:48 [INFO] consul: Adding LAN server linux-node1 (Addr: tcp/127.0.0.1:8300) (DC: dc1)
    2017/07/19 16:36:48 [INFO] consul: Handled member-join event for server "linux-node1.dc1" in area "wan"
    2017/07/19 16:36:48 [INFO] agent: Started DNS server 127.0.0.1:8600 (tcp)
    2017/07/19 16:36:48 [INFO] agent: Started HTTP server on 127.0.0.1:8500
    2017/07/19 16:36:48 [WARN] raft: Heartbeat timeout from "" reached, starting election
    2017/07/19 16:36:48 [INFO] raft: Node at 127.0.0.1:8300 [Candidate] entering Candidate state in term 2
    2017/07/19 16:36:48 [DEBUG] raft: Votes needed: 1
    2017/07/19 16:36:48 [DEBUG] raft: Vote granted from 127.0.0.1:8300 in term 2. Tally: 1
    2017/07/19 16:36:48 [INFO] raft: Election won. Tally: 1
    2017/07/19 16:36:48 [INFO] raft: Node at 127.0.0.1:8300 [Leader] entering Leader state
    2017/07/19 16:36:48 [INFO] consul: cluster leadership acquired
    2017/07/19 16:36:48 [DEBUG] consul: reset tombstone GC to index 3
    2017/07/19 16:36:48 [INFO] consul: member 'linux-node1' joined, marking health alive
    2017/07/19 16:36:48 [INFO] consul: New leader elected: linux-node1
    2017/07/19 16:36:48 [INFO] agent: Synced service 'consul'
    2017/07/19 16:36:48 [DEBUG] agent: Node info in sync

    2017/07/19 16:37:35 [DEBUG] http: Request GET /v1/agent/members (392.644µs) from=127.0.0.1:37719
    2017/07/19 16:38:01 [DEBUG] agent: Service 'consul' in sync
2017/07/19 16:38:01 [DEBUG] agent: Node info in sync

    2017/07/19 16:38:17 [DEBUG] http: Request GET /v1/catalog/nodes (206.082µs) from=127.0.0.1:37721
    2017/07/19 16:38:48 [DEBUG] manager: Rebalanced 1 servers, next active server is linux-node1.dc1 (Addr: tcp/127.0.0.1:8300) (DC: dc1)
    2017/07/19 16:39:12 [DEBUG] agent: Service 'consul' in sync
2017/07/19 16:39:12 [DEBUG] agent: Node info in sync

    2017/07/19 16:39:53 [DEBUG] dns: request for {linux-node1.node.consul. 1 1} (202.173µs) from client 127.0.0.1:40313 (udp)
    2017/07/19 16:40:23 [DEBUG] agent: Service 'consul' in sync
2017/07/19 16:40:23 [DEBUG] agent: Node info in sync
```

# 查看集群中的成员
```
[root@linux-node1 ~]# consul members
Node         Address         Status  Type    Build  Protocol  DC
linux-node1  127.0.0.1:8301  alive   server  0.8.5  2         dc1
```

# 查下节点，两种方式：1）使用http api和dns api查询节点
```
[root@linux-node1 ~]# curl localhost:8500/v1/catalog/nodes
[
    {
        "ID": "86b74e66-9e22-12d3-139a-1a090ab2a041",
        "Node": "linux-node1",
        "Address": "127.0.0.1",
        "Datacenter": "dc1",
        "TaggedAddresses": {
            "lan": "127.0.0.1",
            "wan": "127.0.0.1"
        },
        "Meta": {},
        "CreateIndex": 5,
        "ModifyIndex": 6
    }
]

[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 linux-node1.node.consul       

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 linux-node1.node.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15925
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;linux-node1.node.consul.       IN      A

;; ANSWER SECTION:
linux-node1.node.consul. 0      IN      A       127.0.0.1

;; Query time: 1 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 16:39:53 2017
;; MSG SIZE  rcvd: 57
```
> 脱离节点:可以使用ctrl+c来平滑退出,也可以使用kill退出，区别是主动告知其他节点自己离开，和被其他节点标记为失效，被发现离开


2.2 服务注册
服务注册有两种方式
- 服务定义：是服务注册最常用的方法
- HTTP API：通过HTTP API方式注册
2.2.1 服务注册
# 创建配置文件目录 consul.d是配置文件目录,表示里面有若干个配置文件,这是命名规范
```
[root@linux-node1 ~]# mkdir /etc/consul.d/
```
# 编写服务定义配置文件
```
[root@linux-node1 ~]# echo '{"service": {"name": "web", "tags": ["rails"], "port": 80}}' > /etc/consul.d/web.json
```
# 配置文件内容解释:有个名称为web的服务运行在端口80,另外给他一个标签作为额外的方法查询服务
```
[root@linux-node1 ~]# cat /etc/consul.d/web.json
{"service": {"name": "web", "tags": ["rails"], "port": 80}}
```
# 重启代理并加载配置文件
```
[root@linux-node1 ~]# consul agent -dev -config-dir=/etc/consul.d
…………………………………………
2017/07/19 16:51:16 [INFO] agent: Synced service 'web'
…………………………………………
```
# 输出中表示Synced service”web”服务注册成功,如果想注册多个服务,可以创建多个配置文件

# 通过http API注册服务
```
[root@linux-node1 ~]# curl -X PUT http://127.0.0.1:8500/v1/agent/service/register -i -H "Content-Type:application/json" -H "Accept:application/json" -d '{"ID":"nginx","Name" :"etcd","Tags":["develop"],"Address":"10.10.10.1","Port":8080}'
HTTP/1.1 200 OK
Date: Wed, 19 Jul 2017 08:57:47 GMT
Content-Length: 0
Content-Type: text/plain; charset=utf-8
```

2.2.2 服务注册查询
# 使用DNS API查询服务
可以使用DNS API的方式查看服务的IP,这样只能看到服务的IP，而不能看到Port
```
[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 web.service.consul  

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 web.service.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 42787
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;web.service.consul.            IN      A

;; ANSWER SECTION:
web.service.consul.     0       IN      A       127.0.0.1

;; Query time: 1 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:01:27 2017
;; MSG SIZE  rcvd: 52
```
如果要看到服务的IP和Port,主需要加上SRV
```
[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 web.service.consul SRV

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 web.service.consul SRV
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37694
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;web.service.consul.            IN      SRV

;; ANSWER SECTION:
web.service.consul.     0       IN      SRV     1 1 80 linux-node1.node.dc1.consul.

;; ADDITIONAL SECTION:
linux-node1.node.dc1.consul. 0  IN      A       127.0.0.1

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:06:13 2017
;; MSG SIZE  rcvd: 93

使用DNS API标签过滤服务
[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 rails.web.service.consul SRV

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 rails.web.service.consul SRV
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 51945
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;rails.web.service.consul.      IN      SRV

;; ANSWER SECTION:
rails.web.service.consul. 0     IN      SRV     1 1 80 linux-node1.node.dc1.consul.

;; ADDITIONAL SECTION:
linux-node1.node.dc1.consul. 0  IN      A       127.0.0.1

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:09:05 2017
;; MSG SIZE  rcvd: 99

使用HTTP API查询服务
[root@linux-node1 ~]# curl http://localhost:8500/v1/catalog/service/web
[
    {
        "ID": "c960f5e0-a17f-c9ab-9eac-6461729b52ef",
        "Node": "linux-node1",
        "Address": "127.0.0.1",
        "Datacenter": "dc1",
        "TaggedAddresses": {
            "lan": "127.0.0.1",
            "wan": "127.0.0.1"
        },
        "NodeMeta": {},
        "ServiceID": "web",
        "ServiceName": "web",
        "ServiceTags": [
            "rails"
        ],
        "ServiceAddress": "",
        "ServicePort": 80,
        "ServiceEnableTagOverride": false,
        "CreateIndex": 7,
        "ModifyIndex": 7
    }
]
```
查询服务的健康状态
```
[root@linux-node1 ~]# curl 'http://localhost:8500/v1/health/service/web?passing'
[
    {
        "Node": {
            "ID": "c960f5e0-a17f-c9ab-9eac-6461729b52ef",
            "Node": "linux-node1",
            "Address": "127.0.0.1",
            "Datacenter": "dc1",
            "TaggedAddresses": {
                "lan": "127.0.0.1",
                "wan": "127.0.0.1"
            },
            "Meta": {},
            "CreateIndex": 5,
            "ModifyIndex": 6
        },
        "Service": {
            "ID": "web",
            "Service": "web",
            "Tags": [
                "rails"
            ],
            "Address": "",
            "Port": 80,
            "EnableTagOverride": false,
            "CreateIndex": 7,
            "ModifyIndex": 7
        },
        "Checks": [
            {
                "Node": "linux-node1",
                "CheckID": "serfHealth",
                "Name": "Serf Health Status",
                "Status": "passing",
                "Notes": "",
                "Output": "Agent alive and reachable",
                "ServiceID": "",
                "ServiceName": "",
                "ServiceTags": [],
                "CreateIndex": 5,
                "ModifyIndex": 5
            }
        ]
    }
]
```
2.3 Consul集群
```
主机名称	系统版本	IP	备注		
linux-node1.example.com	CentOS 6.6 x86_64	192.168.200.104			
linux-node2.example.com	CentOS 6.6 x86_64	192.168.200.105			
linux-node3.example.com	CentOS 6.6 x86_64	192.168.200.106			
```
2.3.1 部署集群
```
[root@linux-node1 ~]# consul agent -server \
	-bootstrap-expect=1 \
    -data-dir=/tmp/consul \
	-node=linux-node1.example.com \
	-bind=192.168.200.104 \
	-config-dir=/etc/consul.d
[root@linux-node1 ~]# consul members
Node                     Address               Status  Type    Build  Protocol  DC
linux-node1.example.com  192.168.200.104:8301  alive   server  0.8.5  2         dc1

[root@linux-node2 ~]# consul agent \
	-data-dir=/tmp/consul \
	-node=linux-node2.example.com \
    -bind=192.168.200.105 \
	-config-dir=/etc/consul.d
[root@linux-node2 ~]# consul members
Node                     Address               Status  Type    Build  Protocol  DC
linux-node2.example.com  192.168.200.105:8301  alive   client  0.8.5  2         dc1

[root@linux-node1 ~]# consul join 192.168.200.105
Successfully joined cluster by contacting 1 nodes.
[root@linux-node1 ~]# consul members             
Node                     Address               Status  Type    Build  Protocol  DC
linux-node1.example.com  192.168.200.104:8301  alive   server  0.8.5  2         dc1
linux-node2.example.com  192.168.200.105:8301  alive   client  0.8.5  2         dc1
[root@linux-node2 ~]# consul members
Node                     Address               Status  Type    Build  Protocol  DC
linux-node1.example.com  192.168.200.104:8301  alive   server  0.8.5  2         dc1
linux-node2.example.com  192.168.200.105:8301  alive   client  0.8.5  2         dc1
```
参数注释：
-server	以服务端模式运行
-bootstrap-expect	指定期望加入的节点数,只有达到这个数字才会触发选举
-data-dir	指定数据存放位置
-node	hiding节点名
-bind	指定绑定的IP
-config-dir	指定配置目录
-client	以客户端模式运行

2.3.2 集群基本操作
# 查询节点 两种方式 DNS API及HTTP API
```
[root@linux-node1 ~]# dig @127.0.0.1 -p8600 linux-node1.example.com.node.consul

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p8600 linux-node1.example.com.node.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19815
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;linux-node1.example.com.node.consul. IN        A

;; ANSWER SECTION:
linux-node1.example.com.node.consul. 0 IN A     192.168.200.104

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:53:01 2017
;; MSG SIZE  rcvd: 69

[root@linux-node1 ~]# dig @127.0.0.1 -p8600 linux-node2.example.com.node.consul

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p8600 linux-node2.example.com.node.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37056
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;linux-node2.example.com.node.consul. IN        A

;; ANSWER SECTION:
linux-node2.example.com.node.consul. 0 IN A     192.168.200.105

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:53:07 2017
;; MSG SIZE  rcvd: 69
[root@linux-node1 ~]# dig @127.0.0.1 -p8600 linux-node1.example.com.node.dc1.consul     # 通过consul members查看

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p8600 linux-node1.example.com.node.dc1.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30773
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;linux-node1.example.com.node.dc1.consul. IN A

;; ANSWER SECTION:
linux-node1.example.com.node.dc1.consul. 0 IN A 192.168.200.104

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 17:53:42 2017
;; MSG SIZE  rcvd: 73
```

2.3.3 健康检查
健康检查对于避免将请求发送给运行不正常的服务是一个相当关键的机制，和服务一样,有两种方式来定义检查。
	通过配置文件
	使用HTTP API

第一步：定义检查
在第一个节点的配置文件目录中创建两个文件
```
[root@linux-node1 ~]# echo '{"check": {"name": "ping","script": "ping -c1 google.com >/dev/null", "interval": "30s"}}' >/etc/consul.d/ping.json
[root@linux-node1 ~]# echo '{"service": {"name": "web", "tags": ["rails"], "port": 80,"check": {"script": "curl localhost >/dev/null 2>&1", "interval": "10s"}}}' >/etc/consul.d/web.json
```
以上两个检查如果文件退出状态码非0就标记为不健康


第二步：重载配置
```
[root@linux-node1 ~]# consul reload
Configuration reload triggered

    2017/07/19 18:00:52 [INFO] agent: Synced check 'ping'
    2017/07/19 18:01:00 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:01:10 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:01:20 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:01:30 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:01:40 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:01:50 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:02:00 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:02:08 [INFO] agent: Synced check 'service:web'
    2017/07/19 18:02:10 [WARN] agent: Check 'service:web' is now critical
    2017/07/19 18:02:20 [INFO] agent: Synced check 'service:web'
2017/07/19 18:03:09 [INFO] agent: Synced check 'service:web'
```
根据日志可以看到重新加载配置后,两个检查脚本都成功载入了
ping脚本检查正常,百度是能ping通的,同时由于我们并没有真正在本地启web服务，80端口不存在，也不提供内容，所以检查结果是状态不正常
```
[root@linux-node1 ~]# curl http://localhost:8500/v1/health/state/critical  		# 正常没有输出结果
[][root@linux-node1 ~]# curl http://localhost:8500/v1/health/state/critical	    # 显示异常的服务
[{"Node":"linux-node1.example.com","CheckID":"service:web","Name":"Service 'web' check","Status":"critical","Notes":"","Output":"","ServiceID":"web","ServiceName":"web","ServiceTags":["rails"],"CreateIndex":109,"ModifyIndex":152}][root@linux-node1 ~]#
```
DNS API检查结果 异常情况结果
```
[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 web.service.consul

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 web.service.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 8849
;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;web.service.consul.            IN      A

;; AUTHORITY SECTION:
consul.                 0       IN      SOA     ns.consul. postmaster.consul. 1500458963 3600 600 86400 0

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 18:09:23 2017
;; MSG SIZE  rcvd: 86
```
# 启动httpd服务，服务正常时检查结果
```
[root@linux-node1 ~]# /etc/init.d/httpd start                               
[root@linux-node1 ~]# dig @127.0.0.1 -p 8600 web.service.consul

; <<>> DiG 9.8.2rc1-RedHat-9.8.2-0.30.rc1.el6 <<>> @127.0.0.1 -p 8600 web.service.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7643
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;web.service.consul.            IN      A

;; ANSWER SECTION:
web.service.consul.     0       IN      A       192.168.200.104

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1)
;; WHEN: Wed Jul 19 18:09:53 2017
;; MSG SIZE  rcvd: 52
```

2.4 Consul Key/Value存储
两种方式操作Consul K/V store：HTTP API及Consul KV CLI
```
[root@linux-node1 ~]# consul kv get redis/config/minconns
Error! No key exists at: redis/config/minconns

[root@linux-node1 ~]# consul kv put redis/config/minconns 1
Success! Data written to: redis/config/minconns
[root@linux-node1 ~]# consul kv put redis/config/maxconns 25
Success! Data written to: redis/config/maxconns
[root@linux-node1 ~]# consul kv put -flags=42 redis/config/users/admin abcd1234
Success! Data written to: redis/config/users/admin
[root@linux-node1 ~]# consul kv get redis/config/minconns
1
[root@linux-node1 ~]# consul kv get -detailed redis/config/minconns
CreateIndex      236
Flags            0
Key              redis/config/minconns
LockIndex        0
ModifyIndex      236
Session          -
Value            1
[root@linux-node1 ~]# consul kv get -recurse
redis/config/maxconns:25
redis/config/minconns:1
redis/config/users/admin:abcd1234
[root@linux-node1 ~]# consul kv delete redis/config/minconns
Success! Deleted key: redis/config/minconns
[root@linux-node1 ~]# consul kv get -recurse                
redis/config/maxconns:25
redis/config/users/admin:abcd1234
[root@linux-node1 ~]# consul kv delete -recurse redis
Success! Deleted keys with prefix: redis
[root@linux-node1 ~]# consul kv get -recurse         
[root@linux-node1 ~]# consul kv put foo bar
Success! Data written to: foo
[root@linux-node1 ~]# consul kv get foo
bar
[root@linux-node1 ~]# consul kv put foo zip
Success! Data written to: foo
[root@linux-node1 ~]# consul kv get foo
zip
```

2.5 Consul Web UI
Consul支持开箱即用的功能齐全的网页界面。UI可用于查看所有服务和节点，用于查看所有运行状况检查及其当前状态，以及读取和设置键/值数据。UI自动支持多数据中心。

2.5.1 启动 web UI
[root@linux-node1 ~]# consul agent -ui
http://localhost:8500/ui   # 默认绑定127.0.0.1
两种方式解决：
第一种：--client=0.0.0.0  启动是加上此参数
第二种：配置nginx代理进行查看
```
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
yum install -y nginx
[root@linux-node1 conf.d]# cat /etc/nginx/conf.d/test.conf
upstream test.kaixin001.com {
     server 127.0.0.1:8500;
}


server {
     listen         80;
     server_name    test.kaixin001.com;
     index index.html index.htm;
     root /date/wwwroot/linuxtone/;

     location ~ ^/NginxStatus/ {
             stub_status on;
             access_log off;
      }

     location / {
         root    /date/wwwroot/linuxtone/;
         proxy_redirect off ;
         proxy_set_header Host $host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header REMOTE-HOST $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         client_max_body_size 50m;
         client_body_buffer_size 256k;
         proxy_connect_timeout 30;
         proxy_send_timeout 30;
         proxy_read_timeout 60;
         proxy_buffer_size 256k;
         proxy_buffers 4 256k;
         proxy_busy_buffers_size 256k;
         proxy_temp_file_write_size 256k;
         proxy_next_upstream error timeout invalid_header http_500 http_503 http_404;
         proxy_max_temp_file_size 128m;
         proxy_pass    http://test.kaixin001.com;
     }
}
/etc/init.d/nginx configtest
/etc/init.d/nginx start
http://test.kaixin001.com/
```

3、Consul进阶
https://www.consul.io/docs/guides/index.html

consul-template
Registrator

http://zhaijunming5.blog.51cto.com/10668883/1768321
https://www.ibm.com/developerworks/cn/cloud/library/cl-plug-and-play-service-discovery-with-consul-and-docker-bluemix/
http://genchilu-blog.logdown.com/posts/317095-based-on-swarm-and-consul-ha-and-dynamically-extensible-architectures
http://dockone.io/article/272
http://dockone.io/article/2189
https://gliderlabs.com/registrator/latest/
http://dockone.io/article/1567
http://dockone.io/article/1359
http://dockone.io/article/667


4、Registrator

官网：https://gliderlabs.com/registrator/latest/
GitHub地址：https://github.com/gliderlabs/registrator

Registrator 监听新建容器，并检查他们确定他们提供什么服务。为了我们的目的，一个服务是在一个端口上监听的东西，Registrator可以发现容器提供的任何服务，他们将被添加到服务注册表，如consul等。

案例：使用registrator与consul，并运行一个redis容器，将自动添加到consul

第一步：在linux-node3.example.com主机上部署docker服务 用于部署consul及registrator服务
```
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
yum install -y docker-io
/etc/init.d/docker start
chkconfig docker on
```
第二步：启动一个consul实例
```
[root@linux-node3 ~]# docker pull gliderlabs/consul-server
[root@linux-node3 ~]# docker run -d --name=consul --net=host gliderlabs/consul-server -bootstrap
[root@linux-node3 ~]# docker start 435bbbf5cabc
```
实验报错待解决：
```
[root@linux-node3 ~]# docker logs 435bbbf5cabc
==> WARNING: Bootstrap mode enabled! Do not enable unless necessary
==> Starting Consul agent...
==> Error starting agent: Failed to get advertise address: Multiple private IPs found. Please configure one.
```
改用非docker启动consul服务，启动并查看注册的服务内容
```
[root@linux-node3 ~]# curl 192.168.200.104:8500/v1/catalog/services
{"consul":[],"web":["rails"]}
```
第三步：运行registrator
Registrator运行在每台主机上，启动registrator的主要配置是如何连接它的registry, 或者 Consul in this case.
除去选型标识，只需要告诉registrator如何连接consul
```
[root@linux-node3 ~]# docker run -d \
--name=registrator \
--net=host \
--volume=/var/run/docker.sock:/tmp/docker.sock \
gliderlabs/registrator:latest \
consul://localhost:8500

[root@linux-node3 ~]# docker ps
CONTAINER ID        IMAGE                    COMMAND          CREATED          STATUS        PORTS  NAMES
8fb2639aa87c        gliderlabs/registrator:latest    "/bin/registrator co   10 seconds ago      Up 9 seconds          registrator         
[root@linux-node3 ~]# docker logs registrator
2017/07/20 06:27:19 Starting registrator v7 ...
2017/07/20 06:27:19 Using consul adapter: consul://localhost:8500
2017/07/20 06:27:19 Connecting to backend (0/0)
2017/07/20 06:27:19 consul: current leader  192.168.200.104:8300
2017/07/20 06:27:19 Listening for Docker events ...
2017/07/20 06:27:19 Syncing services on 1 containers
2017/07/20 06:27:19 ignored: 8fb2639aa87c no published ports
```

第三四：启动redis查看服务注册情况
```
[root@linux-node3 ~]# docker run -d -P --name=redis redis
[root@linux-node2 ~]# docker run -d -P --name=mongo mongo
[root@linux-node3 ~]# docker run -d -P --name=httpd httpd
[root@linux-node2 ~]# docker run -d -P --name=mongo mongo
[root@linux-node2 ~]# docker run -d -P --name=mysql mysql
[root@linux-node2 ~]# docker logs mysql
error: database is uninitialized and password option is not specified
  You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD
[root@linux-node2 ~]# docker run -d -P --name=mysql -e MYSQL_ROOT_PASSWORD='123456' mysql
[root@linux-node3 ~]# docker ps
CONTAINER ID   IMAGE                    COMMAND          CREATED        STATUS         PORTS                     NAMES
4c17151acd85   httpd                     "httpd-foreground"    21 seconds ago   Up 20 seconds   0.0.0.0:32769->80/tcp     httpd
7c3681e5c0f1    redis                     "docker-entrypoint.s   9 seconds ago    Up 7 seconds    0.0.0.0:32768->6379/tcp   redis               
8fb2639aa87c    gliderlabs/registrator:latest  "/bin/registrator co    3 minutes ago     Up 3 minutes                           registrator  
[root@linux-node2 ~]# docker ps
CONTAINER ID   IMAGE        			COMMAND          CREATED             STATUS              PORTS                      NAMES
af5cbec7b208   mysql          			"docker-entrypoint.s   5 seconds ago       Up 4 seconds    0.0.0.0:32770->3306/tcp    mysql               
85beac6acb4a   gliderlabs/registrator:latest   "/bin/registrator co   17 minutes ago       Up 17 minutes                           registrator         
70dd029f91de   mongo        			"docker-entrypoint.s   21 minutes ago      Up 21 minutes   0.0.0.0:32768->27017/tcp   mongo  
[root@linux-node3 ~]# curl 192.168.200.104:8500/v1/catalog/services
{
    "consul": [],
    "redis": [],
    "web": [
        "rails"
    ]
}
[root@linux-node3 ~]# curl 192.168.200.104:8500/v1/catalog/service/redis
[
    {
        "ID": "ff3664fd-1f69-703d-1867-185dd7a13fae",
        "Node": "linux-node3.example.com",
        "Address": "192.168.200.106",
        "Datacenter": "dc1",
        "TaggedAddresses": {
            "lan": "192.168.200.106",
            "wan": "192.168.200.106"
        },
        "NodeMeta": {},
        "ServiceID": "linux-node3:redis:6379",
        "ServiceName": "redis",
        "ServiceTags": [],
        "ServiceAddress": "",
        "ServicePort": 32768,
        "ServiceEnableTagOverride": false,
        "CreateIndex": 2867,
        "ModifyIndex": 2867
    }
]
```
通过consul UI查看注册及验证服务



根据页面信息验证服务
Httpd服务：

Redis服务：
MySQL服务：
```
[root@linux-node1 ~]# mysql -uroot -p -h192.168.200.105 -P32770
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.19 MySQL Community Server (GPL)

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)
mysql> select user,host,authentication_string from mysql.user;
+-----------+-----------+-------------------------------------------+
| user      | host      | authentication_string                     |
+-----------+-----------+-------------------------------------------+
| root      | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
| root      | %         | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
| mysql.sys | localhost | *THISISNOTAVALIDPASSWORDTHATCANBEUSEDHERE |
+-----------+-----------+-------------------------------------------+
3 rows in set (0.00 sec)
```

注释：
Option	Required	Description
--volume=/var/run/docker.sock:/tmp/docker.sock	yes	Allows Registrator to access Docker API
--net=host	recommended	Helps Registrator get host-level IP and hostname
5、consul-template
5.1 Consul-template部署及基本应用
官网：https://www.hashicorp.com/blog/introducing-consul-template/
GitHub：https://github.com/hashicorp/consul-template
可以通过监听 consul 的注册信息，来完成本地应用的配置更新

部署及应用案例
```
[root@linux-node3 ~]# wget https://releases.hashicorp.com/consul-template/0.19.0/consul-template_0.19.0_linux_amd64.zip
[root@linux-node3 ~]# unzip consul-template_0.19.0_linux_amd64.zip
[root@linux-node3 ~]# mv consul-template /usr/bin/
[root@linux-node3 ~]# consul-template --help
[root@linux-node3 ~]# vim in.tpl
{{ key "foo" }}
[root@linux-node3 ~]# consul-template -template "in.tpl:out.txt" -once
[root@linux-node3 ~]# cat out.txt
zip
[root@linux-node3 ~]# consul kv put foo bar
Success! Data written to: foo
[root@linux-node3 ~]# consul-template -template "in.tpl:out.txt" -once
[root@linux-node3 ~]# cat out.txt                                     
bar
```
更多详细说明及案例：https://github.com/hashicorp/consul-template

完整应用案例
主机名称	系统版本	IP	备注		
linux-node4.example.com	CentOS 7.2.1511 x86_64	192.168.200.114			
linux-node5.example.com	CentOS 7.2.1511 x86_64	192.168.200.115			

[root@linux-node3 ~]# yum install -y python-pip
[root@linux-node3 ~]# pip install --upgrade pip
[root@linux-node3 ~]# pip install docker-compose
下载保存该文件https://github.com/yeasy/docker-compose-files/blob/master/consul-discovery/docker-compose.yml保存为docker-compose.yml

http://m635674608.iteye.com/blog/2358242 安装docker-compose报错

http://www.bubuko.com/infodetail-1047040.html

5.2 Consul-template实践应用案例
用Consul+Consul-template+Registrator+Nginx打造真正可动态扩展的服务架构
http://www.bubuko.com/infodetail-1047040.html
http://blog.csdn.net/a821478424/article/details/51607183

5.2.1 架构讲解
snginx前端作为负载均衡器使用，它代理了三台能提供web服务的服务器，每一台服务器上均安装consul，并以agent的形式运行在服务器上，并将Consul Agent加入到Consul Cluster中。Consul-template与Consul Cluster的Server连接，动态的从Consul的服务信息库汇中拉取nginx代理的三台服务器的IP、端口号等信息，并将IP地址以及端口号写入到nginx的配置文件中，在完成一次写入后（即后台服务发生变更时），Consul-template将自动将nginx重启加载，实现nginx应用新配置文件的目的。


5.2.2 部署实践步骤梳理
- 构建Consul集群（docker化实现）
- 构建web应用服务
- 部署配置consul-template与nginx联动
- 验证与测试

5.2.3 操作记录
