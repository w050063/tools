官网文档:https://www.elastic.co/guide/en/elastic-stack/5.6/index.html

http://10.1.16.152:9200/_cluster/settings

# Cluster APIs
官网文档:https://www.elastic.co/guide/en/elasticsearch/reference/5.6/cluster.html
## Cluster Health
## Cluster State
## Cluster Stats
## Pending cluster tasks
## Cluster Reroute
## Cluster Update Settings
## Nodes Stats
## Nodes Info
## Remote Cluster Info
## Task Management API
## Nodes hot_threads
## Cluster Allocation Explain API


http://10.1.16.152:9200/_cluster/health


1. 获取当前所有index配置
```
curl -XGET http://10.1.16.152:9200/_settings
```

2. 获取某些index的配置
```
curl -XGET http://10.1.16.152:9200/graylog_0/_settings
curl -XGET http://10.1.16.152:9200/graylog_*/_settings
```

3. 动态修改某些index配置，增加replica
```
curl -XPUT http://10.1.16.152:9200/graylog_1/_settings -d '{"number_of_replicas":1}'
```

4. 动态修改某些index配置，删除replica
```
curl -XPUT http://10.1.16.152:9200/graylog_1/_settings -d '{"number_of_replicas":0}'
```

https://www.elastic.co/guide/en/elasticsearch/reference/5.6/indices.html
