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
```
# FQA
# 参考资料 
