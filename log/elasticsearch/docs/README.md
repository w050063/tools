官网文档:https://www.elastic.co/guide/en/elastic-stack/5.6/index.html

# [入门 Getting Started](https://github.com/mds1455975151/tools/blob/master/log/elasticsearch/docs/getting-started.md)
## [基本概念 Basic Concepts](https://github.com/mds1455975151/tools/blob/master/log/elasticsearch/docs/basic_concepts.md)
## [Installation]()
## [Exploring Your Cluster]()
## [Modifying Your Data]()
## [Exploring Your Data]()
## [Conclusion]()

# Set up Elasticsearch
# Set up X-Pack
# Breaking changes
# API Conventions
# Document APIs
# Search APIs
# Aggregations
# Indices APIs
# cat APIs
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
# Query DSL
# Mapping
# Analysis
# Modules
# Index Modules
# Ingest Node
# X-Pack APIs
# X-Pack Commands
# How To
# Testing
# Glossary of terms
# Release Highlights
# Release Notes


http://10.1.16.152:9200/_cluster/settings

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
