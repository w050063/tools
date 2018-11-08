# Redis知识总结
## Redis概述

## Redis常见使用方式及优缺点
### Redis单副本
采用单个Redis节点部署架构，没有备用节点实时同步数据，不提供数据持久化和备份策略，适用于数据可靠性要求不高的纯缓存业务场景。
```
      client
         |
         |
         V
       Redis
或者
      client
        |
        | VIP
        V
     keepalive
Redis<------->Redis
```
优点:
- 架构简单，部署方便
- 高性价比：缓存使用时无需备用节点(单实例可以使用supervisor或crontab保证)
- 高性能

缺点:
- 不能保证数据的可靠性
- 进程重启数据丢失，即使有备用的节点解决高可用性，但无法解决缓存预热问题，因此不适用与数据可靠性要求高的业务
- 高性能受单CPU处理能力，CPU为主要瓶颈，所以适合操作命令简单，排序、计算较少的场景。
### Redis多副本(主从)
Redis多副本，采用主从（replication）部署结构，相较于单副本而言最大的特点就是主从实例间数据实时同步，并且提供数据持久化和备份策略。主从实例部署在不同的物理服务器上，根据公司的基础环境配置，可以实现同时对外提供服务和读写分离策略。

### Redis Sentinel(哨兵)
### Redis Cluster
### Redis 自研

## Redis安装部署
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/redis/install_redis.sh
sh install_redis.sh
```
## Redis日常使用
``` text
127.0.0.1:6381> dbsize  // 查看key数量
(integer) 3112
```
## Redis多实例
``` bash
cp /etc/redis-6380.conf /etc/redis-6381.conf
sed -i 's/6380/6381/g' /etc/redis-6381.conf
mkdir -p /var/lib/redis-6381
redis-server /etc/redis-6381.conf
netstat -tunlp
cat>>/etc/rc.local<<EOF
redis-server /etc/redis-6381.conf
EOF
```
## Redis性能压测
## twemproxy
- 编译
- 安装
- 配置
- 性能测试
## codis
## 可视化管理工具
- redis的图形化工具
  - redis-stat
  - redis-browser
  - redis-live
- [redis desktop manager](https://redisdesktop.com/download)

## to-do-list
- 部署安装
- 多实例
- 日常使用
- Redis Sentinel(哨兵)
- Redis Cluster


## 参考资料
- [CentOS 7下Rinetd安装与应用](https://www.cnblogs.com/zhenyuyaodidiao/p/5540209.html)
