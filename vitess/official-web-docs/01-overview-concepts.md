# Key Concepts 重要概念
## Contents 内容
本文档定义了常见的Vitess概念和术语。
## Keyspace 密钥空间
一个keyspace是一个逻辑数据库。在未shard的情况下，它直接映射到MySQL数据库名称。如果shard，一个keyspace映射到多个MySQL数据库。但是，它显示为应用程序的单个数据库。

从keyspace读取数据就像从MySQL数据库读取数据一样。但是，根据读取操作的一致性要求，Vitess可能会从主数据库或副本中获取数据。通过将每个查询路由到适当的数据库，Vitess允许您的代码被结构化，就像它从单个MySQL数据库读取一样。
## Keyspace ID
Keyspace ID 是用来决定哪些分片给定行的生命值。基于范围的分片是指创建分别覆盖特定范围的keyspaces id的分片。

使用这种技术意味着您可以拆分给定分片，方法是将两个或更多新分片替换为覆盖原始密钥空间ID范围的新分片，而不必在其他分片中移动任何记录。

密钥空间ID本身是使用数据中的某个列的函数计算的，例如用户ID。Vitess允许您从各种功能（vindexes）中进行选择以执行此映射。这使您可以选择正确的数据以实现分片间数据的最佳分配。

## VSchema
一个VSchema允许您描述数据是如何keyspaces和shard内组织。此信息用于路由查询，也用于重新分片操作。

对于Keyspace，你可以指定它是否被分割。对于分片密钥空间，可以为每个表指定vindex的列表。

Vitess还支持序列生成器 ，可用于生成像MySQL自动增量列一样工作的新ID。VSchema允许您将表格列与序列表相关联。如果没有为这样的列指定值，那么VTGate将知道使用序列表为其生成一个新值。

### Shard 分片
a shard 是一个keyspaces中的分割。shard通常包含一个MySQL主服务器和许多MySQL从服务器。

shard中的每个MySQL实例都具有相同的数据（除了一些复制滞后）。slaves可以提供只读流量（最终一致性保证），执行长时间运行的数据分析工具或执行管理任务（备份，恢复，差异等）。

An unsharded keyspace实际上具有one shard。Vitess按照惯例命名碎片0。分片时，密钥空间具有N 非重叠数据的碎片。
## Resharding 重新shard
Vitess支持动态重新分片，其中在活动群集中更改分片数量。这可以是将一个或多个shard分割成smaller pieces，也可以将相邻的碎片合并为更大的碎片。

在动态重新分片期间，将源分片中的数据复制到目标分片中，允许跟上复制，然后与原始分片进行比较以确保数据完整性。然后，实时服务基础架构转移到目标碎片，并删除源碎片。

## Tablet
  Tablet是一个MySQL进程和相应的vttablet过程中，通常在相同的机器上运行。

  每个tablet都分配有tablet type，用于指定当前执行的角色。
### Tablet Types
- **master** - A replica tablet that happens to currently be the MySQL master for its shard.
- **replica** - A MySQL slave that is eligible to be promoted to master. Conventionally, these are reserved for serving live, user-facing requests (like from the website's frontend).
  有资格升级为master。通常，这些保留用于提供实时的，面向用户的请求
- **rdonly** - A MySQL slave that cannot be promoted to master. Conventionally, these are used for background processing jobs, such as taking backups, dumping data to other systems, heavy analytical queries, MapReduce, and resharding.
  无法升级为master的MySQL slave。通常，这些用于后台处理作业，例如：备份，将数据转储到其他系统，繁重的分析查询，MapReduce和重新分割等。
- **backup** - A tablet that has stopped replication at a consistent snapshot, so it can upload a new backup for its shard. After it finishes, it will resume replication and return to its previous type.
  停止一直快照复制的tablet，因此可以为其分片上传新的备份，完成后，它将恢复复制并返回之前的类型
- **restore** - A tablet that has started up with no data, and is in the process of restoring itself from the latest backup. After it finishes, it will begin replicating at the GTID position of the backup, and become either replica or rdonly.
  启动时没有数据的tablet，并正在从最新备份恢复自身。完成后，它将开始在备份的GTID位置进行复制，并成为 replica or rdonly
- **drained** - A tablet that has been reserved by a Vitess background process (such as rdonly tablets for resharding).
  Vitess后台进程保留的tablet(如用于重新shard的rdonly tablet)


## Keyspace Graph
### Partitions
### Served From
## Replication Graph
## Topology Service
### Global Topology
### Local Topology
## Cell (Data Center)
