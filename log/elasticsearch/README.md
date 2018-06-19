## Elasticsearch

官网文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
5.6官网文档：https://www.elastic.co/guide/en/elasticsearch/reference/5.6/index.html

### API
#### Search APIs
#### Indices APIs
#### cat APIs
``` text
curl -X GET http://localhost:9200/_cat/indices?v		//获取索引列表
curl -X GET http://localhost:9200/_cat/health?v			//获取状态
curl -X GET http://localhost:9200/graylog_deflector		//获取指定索引信息graylog_deflector
curl -X PUT http://localhost:9200/customer?pretty		//创建索引customer
curl -X DELETE http://localhost:9200/customer?pretty	//删除索引customer
curl -X GET http://localhost:9200/graylog_deflector/_search?pretty		//在指定索引中搜索数据
```
#### Cluster APIs

[How to add a new node to my Elasticsearch cluster](https://stackoverflow.com/questions/35717790/how-to-add-a-new-node-to-my-elasticsearch-cluster)

http://10.1.16.152:9200/_cluster/settings?pretty

 - 确定节点version,保持节点版本一致性
  > http://10.1.16.152:9200/

elasticsearch官网文档过一遍

# to-do-list
- Elasticsearch部署
- Elasticsearch添加删除node
- Elasticsearch服务监控
- Elasticsearch数据备份和恢复
- Elasticsearch数据迁移
