> [探索数据](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/_exploring_your_data.html)

基本知识了解后，研究一个更真实的数据集。准备一个关于银行客户账号信息的虚拟json文档样本。每个文档都有如下字段：
``` json
{
    "account_number": 0,
    "balance": 16623,
    "firstname": "Bradshaw",
    "lastname": "Mckenzie",
    "age": 29,
    "gender": "F",
    "address": "244 Columbus Place",
    "employer": "Euron",
    "email": "bradshawmckenzie@euron.com",
    "city": "Hobucken",
    "state": "CO"
}
```
数据生成方法：https://next.json-generator.com/

# 加载示例数据
```
wget -O accounts.json "https://github.com/elastic/elasticsearch/blob/master/docs/src/test/resources/accounts.json?raw=true"
curl -H "Content-Type: application/json" -XPOST "10.1.16.152:9200/bank/account/_bulk?pretty&refresh" --data-binary "@accounts.json"
curl "10.1.16.152:9200/_cat/indices?v"
```
成功将1000条记录批量索引到bank索引 account类型

## The Search API 搜索API
开始一些简单搜索。运行检索两种方式：1、通过发送搜索参数REST request URI 2、发送REST request body

用于搜索的REST API可以从_search访问。本示例返回bank index中所有信息：
```
curl -X GET "10.1.16.152:9200/bank/_search?q=*&sort=account_number:asc&pretty"
```
q=* : 指示Elasticsearch匹配index中所有document
sort=account_number:asc : 表示按每个document中account_number字段进行升序排序
pretty：返回json结构

the response 响应部分，包括如下部分：
- took: 执行搜索时间(毫秒为单位)
- timed_out：搜索是否超时
- _ shards : 告诉我们搜索了多少shard,已经搜索shard成功/失败的次数
- hits：搜索结果
- hits.total:符合搜索条件的document总数
- hits.hits：实际的搜索结果数据(默认为前10个document)
- hits.sort:结果排序
- hits._ score and max_score 忽略这些字段

使用替代request body method进行相同的精确搜索：
```
curl -X GET "10.1.16.152:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "sort": [
    { "account_number": "asc" }
  ]
}
'

```
## Introducing the Query Language 介绍查询语言
```
match_all:在指定在所有的所有document中进行搜索
curl -X GET "localhost:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} }
}
'
添加size参数，不指定默认为10
curl -X GET "localhost:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "size": 1
}
'


返回10-19号document， from不指定，默认为0 (实现分页搜索时非常有用)
curl -X GET "localhost:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "from": 10,
  "size": 10
}
'

实例：按照账户余额降序排列，返回前10个记录
curl -X GET "localhost:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "sort": { "balance": { "order": "desc" } }
}
'
```
## Executing Searches 执行搜索
## Executing Filters 执行过滤器
## Executing Aggregations 执行聚合
