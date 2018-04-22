## Elasticsearch

官网文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html

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



