# MongoDB知识
## MongoDB概述
- 官网：https://www.mongodb.com/
- 官网文档：https://docs.mongodb.com
- GitHub地址：https://github.com/mongodb/mongo

## MongoDB部署
### 单机部署
### 副本集部署
``` bash
ansible-playbook host-init-qq.yml -i ../hosts.mongodb -l mongodb
ansible-playbook install_mongodb_replica_set.yml -i ../hosts.mongodb -l mongodb


rs.isMaster()


rs.add()       为复制集新增节点。    
rs.addArb()    为复制集新增一个 arbiter    
rs.conf()      返回复制集配置信息    
rs.freeze()    防止当前节点在一段时间内选举成为主节点。     
rs.help()      返回 replica set 的命令帮助     
rs.initiate()    初始化一个新的复制集。     
rs.printReplicationInfo()         以主节点的视角返回复制的状态报告。     
rs.printSlaveReplicationInfo()    以从节点的视角返回复制状态报告。     
rs.reconfig()    通过重新应用复制集配置来为复制集更新配置。     
rs.remove()      从复制集中移除一个节点。     
rs.slaveOk()     为当前的连接设置 slaveOk 。不推荐使用。使用 readPref() 和 Mongo.setReadPref() 来设置 read preference 。     
rs.status()      返回复制集状态信息。    
rs.stepDown()    让当前的 primary 变为从节点并触发 election 。     
rs.syncFrom()    设置复制集节点从哪个节点处同步数据，将会覆盖默认选取逻辑。
 
```
# FQA
# 参考资料 
