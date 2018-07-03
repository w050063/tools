> 索引模型 http://docs.graylog.org/en/2.4/pages/configuration/index_model.html

# Overview 概述
graylog透明的管理一组或多组Elasticsearch索引，以优化搜索和分析操作，以实现速度和低资源消耗。

为了能够管理具有不同映射、分析器和复制设置的索引，graylog使用所谓的索引集，这些索引集时所有这些设置的抽象。

每个索引集都包含graylog创建，管理和填充Elasticsearch索引以及处理特定需要的索引切换和数据保留所必须的设置。

Graylog维护每个索引集的索引别名，该索引别名始终指向该索引集的当前写入活动索引。在满足配置的轮换标准（文档数，索引大小或索引年龄）之前，始终只有一个索引要写入新消息。

后台任务不断检查是否已满足索引集的旋转标准，并在发生时创建并准备新索引。索引准备就绪后，索引别名将自动切换到它。这意味着所有Graylog节点都可以将消息写入别名，甚至不知道索引集的当前写入活动索引是什么。

几乎每个读取操作都在给定的时间范围内执行。由于Graylog按顺序将消息写入Elasticsearch，因此可以保留每个索引所涵盖的时间范围的信息。它在提供时间范围时选择要查询的索引列表。如果没有提供时间范围，它将搜索它知道的所有指数。

## Eviction of indices and messages
Graylog在给定索引集中管理的最大索引数有配置设置。

根据配置的保留策略，当达到配置的最大索引数时，将自动关闭，删除或导出索引集的最旧索引。

删除由后台线程中的Graylog主节点执行，后台线程不断地将索引数与配置的最大值进行比较：
```
INFO : org.graylog2.indexer.rotation.strategies.AbstractRotationStrategy - Deflector index <graylog_95> should be rotated, Pointing deflector to new index now!
INFO : org.graylog2.indexer.MongoIndexSet - Cycling from <graylog_95> to <graylog_96>.
INFO : org.graylog2.indexer.MongoIndexSet - Creating target index <graylog_96>.
INFO : org.graylog2.indexer.indices.Indices - Created Graylog index template "graylog-internal" in Elasticsearch.
INFO : org.graylog2.indexer.MongoIndexSet - Waiting for allocation of index <graylog_96>.
INFO : org.graylog2.indexer.MongoIndexSet - Index <graylog_96> has been successfully allocated.
INFO : org.graylog2.indexer.MongoIndexSet - Pointing index alias <graylog_deflector> to new index <graylog_96>.
INFO : org.graylog2.system.jobs.SystemJobManager - Submitted SystemJob <f1018ae0-dcaa-11e6-97c3-6c4008b8fc28> [org.graylog2.indexer.indices.jobs.SetIndexReadOnlyAndCalculateRangeJob]
INFO : org.graylog2.indexer.MongoIndexSet - Successfully pointed index alias <graylog_deflector> to index <graylog_96>.
```

# Index Set Configuration 索引集配置
索引集具有与Graylog如何将消息存储到Elasticsearch集群相关的各种不同设置。

- 标题：索引集的描述性名称。
- 描述：人类消费指数集的描述。
- 索引前缀：用于由索引集管理的弹性搜索索引的唯一前缀。前缀必须以字母或数字开头，并且只能包含字母，数字_，-和+。索引别名将相应地命名，例如，graylog_deflector如果索引前缀是graylog。
- Analyzer :(默认值standard：）索引集的Elasticsearch 分析器。
- 索引分片 :(默认值：4）每个索引使用的Elasticsearch分片数。
- 索引副本 :(默认值：0）每个索引使用的Elasticsearch副本数。
- 最大。段数 :(默认值：1）索引优化（强制合并）后每个Elasticsearch索引的最大段数，有关详细信息，请参阅段合并。
- 旋转后禁用索引优化：在索引旋转后禁用Elasticsearch 索引优化（强制合并）。只有在优化过程中出现Elasticsearch集群性能严重问题时才激活此项。

## Index rotation 索引轮询
- 消息计数：在写入特定数量的消息后旋转索引。
- 索引大小：在达到磁盘上的大致大小（优化之前）后旋转索引。
- 索引时间：在特定时间（例如1小时或1周）后旋转索引。

## Index retention 索引保留
- 删除：删除 Elasticsearch中的索引以最小化资源消耗。
- 关闭：关闭 Elasticsearch中的索引以减少资源消耗。
- 没做什么
- 存档：商业功能，请参阅存档。

# Maintenance 维护

## Keeping the index ranges in sync
## Manually rotating the active write index
