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

rs.status()
rs.add("192.168.1.4:27017")
rs.isMaster()

6、在主节点上创建数据，从节点是否获取到
testrs0:PRIMARY> use testdb
switched to db testdb 
testrs0:PRIMARY> db.testcoll.insert({Name: "test",Age: 50,Gender: "F"})
WriteResult({ "nInserted" : 1 })
testrs0:PRIMARY> db.testcoll.find()
{ "_id" : ObjectId("55b9945b92ad0ab98483695e"), "Name" : "test", "Age" : 60, "Gender" : "F" }
{ "_id" : ObjectId("55b994ce92ad0ab98483695f"), "Name" : "test", "Age" : 50, "Gender" : "F" }

在从节点上查询，是不可以直接查询，要使用一个命令rs.slave()把自己提升为从节点
testrs0:SECONDARY> rs.slaveOk()
testrs0:SECONDARY> use testdb;
switched to db testdb
testrs0:SECONDARY> db.testcoll.find()
{ "_id" : ObjectId("55b9945b92ad0ab98483695e"), "Name" : "test", "Age" : 60, "Gender" : "F" }
{ "_id" : ObjectId("55b994ce92ad0ab98483695f"), "Name" : "test", "Age" : 50, "Gender" : "F" }
 
```
# FQA
# 参考资料 
