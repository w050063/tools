## Elasticsearch

- 官网文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
- 5.6官网文档：https://www.elastic.co/guide/en/elasticsearch/reference/5.6/index.html

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

How to add a new node to my Elasticsearch cluster

- [参考资料](https://stackoverflow.com/questions/35717790/how-to-add-a-new-node-to-my-elasticsearch-cluster)
- [验证过程](  https://github.com/mds1455975151/tools/blob/master/log/elasticsearch/docs/add_node_to_cluster.md)

http://10.1.16.152:9200/_cluster/settings?pretty

 - 确定节点version,保持节点版本一致性
  > http://10.1.16.152:9200/

es优化：https://mp.weixin.qq.com/s/0TMESj2Z-XK2PzwBQo0Mpg
# 相关工具
## 基础类工具
- head插件
```
ES集群状态查看、索引数据查看、ES DSL实现（增、删、改、查操作）
比较实用的地方：json串的格式化
GitHub地址：http://mobz.github.io/elasticsearch-head/
```

- Kibana
```
除了支持各种数据的可视化之外，最重要的是：支持Dev Tool进行RESTFUL API增删改查操作。比Postman工具和curl都方便很多。
地址：https://www.elastic.co/products/kibana
```

- ElasticHD
```
强势功能——支持sql转DSL，不要完全依赖，可以借鉴用。
GitHub地址：https://github.com/360EntSecGroup-Skylar/ElasticHD
```

## 集群监控工具
- cerebro
```
GitHub地址：https://github.com/lmenezes/cerebro
```

- Elaticsearch-HQ
```
管理elasticsearch集群以及通过web界面来进行查询操作
GitHub地址：https://github.com/royrusso/elasticsearch-HQ
```
# to-do-list
- elasticsearch官网文档过一遍
- ~~Elasticsearch部署~~
- ~~Elasticsearch添加node~~
- Elasticsearch服务监控
- Elasticsearch数据备份和恢复

- Elasticsearch数据迁移
- [Elasticsearch索引迁移](https://blog.csdn.net/laoyang360/article/details/65449407)
  - [elaticserch-dump](https://github.com/taskrabbit/elasticsearch-dump)
  - [Elasticsearch-Exporter](https://github.com/mallocator/Elasticsearch-Exporter)
  - logstash定向索引迁移
  - elasticsearch-migration 升级elasticsearch使用
