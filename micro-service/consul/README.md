# Consul概述
![images](https://github.com/mds1455975151/tools/blob/master/micro-service/consul/images/01.png)
- 官网：https://www.consul.io/
- 官网文档：https://www.consul.io/intro/index.html

## Consul功能
- 服务发现
- 健康检查
- Key/value存储
- 支持多数据中心

## Consul使用场景
- Docker实例的注册与配置共享
- Coreos实例的注册与配置共享

## Consul优势
- 使用Raft算法来保证一致性, 比复杂的 Paxos 算法更直接. 相比较而言, zookeeper 采用的是 Paxos, 而 etcd 使用的则是 Raft
- 支持多数据中心，内外网的服务采用不同的端口进行监听。 多数据中心集群可以避免单数据中心的单点故障,而其部署则需要考虑网络延迟, 分片等情况等. zookeeper 和 etcd 均不提供多数据中心功能的支持
- 支持健康检查. etcd 不提供此功能
- 官方提供web管理界面, etcd 无此功能
- 支持 http 和 dns 协议接口. zookeeper 的集成较为复杂, etcd 只支持 http 协议

## Consul发现机制

当一个Consul代理启动后，它并不知道其它节点的存在，它是一个孤立的 单节点集群，如果想感知到其它节点的存在，它必须加入到一个现存的集群，要加入到一个现存的集群，它只用加入集群中任意一个现存的成员，当加入一个现存的成员后，会通过成员间的通讯很快发现集群中的其它成员，一个Consul代理可以加入任意一个代理，而不仅仅是服务节点

## Consul角色
- Client：注册服务、健康检查并将数据发送到服务端
- server：保存配置信息, 高可用集群, 在局域网内与本地客户端通讯, 通过广域网与其他数据中心通讯

consul+nginx
