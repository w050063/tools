## Overview 概述
  Vitess是用于部署，扩展和管理大型MySQL实例集群的数据库解决方案。它的架构可以像在专用硬件上那样有效的在公有云或私有云架构中运行。它结合并扩展了许多重要的MySQL功能和NoSQL数据库的可扩展性。Vitess可以帮助你解决如下问题：
- 允许您对MySQL数据库进行分片来扩展MySQL数据库，同时将应用程序更改保持在最低延迟下
- 从裸机迁移至私有云或公有云
- 部署和管理大量的MySQL实例

Vitess包含使用本地查询协议的兼容JDBC和Go数据库驱动程序。此外它还实现了几乎与任何其他语言兼容的MySQL服务器协议。
Vitess自2011年以来一直服务于所有的YouTube数据库流量，并且现在已被许多企业用于满足其生产需求。
### Features 特性
 - Performance 性能
  - 连接池-将多个前端应用程序查询到MySQL连接池以优化性能
  - 查询重复删除
  - 事务管理器-限制并发事务的数量并管理期限以优化整体吞吐量
 - Protection 保护
  - 查询重写和清理
  - 查询黑名单-自定义规则以防止可能存在问题的查询触击您的数据库
  - 查询杀手-终止需要很长时间才能返回数据的查询
  - 表ACL-根据连接的用户为表指定访问控制列表（ACL）
 - Monitoring 监控
  - 性能分析-使用工具可以监视，诊断和分析数据库性能
  - 查询流式传输-使用传入查询列表来为OLAP工作负载提供服务
  - 更新流-服务器对数据库中更改的行进行流式处理，这可以用作将更改传播到其他数据存储的机制。
 - Topology Management Tools 拓扑管理工具
  - 主管理工具 (handles reparenting)
  - 基于web的管理GUI
  - 设计用于多个数据中心/地区
 - Sharding 拆分
  - 几乎无缝的动态重新分片
  - 垂直和水平分片支持
  - 多种分片方案，能够插入自定义分片
### Comparisons to other storage options 与其他存储选项进行比较
以下各节将Vitess与两种常见的替代方法进行比较，一个是vanilla MySQL实现一个NoSQL实现。
- Vitess vs. Vanilla MySQL
 略
- Vitess vs. NoSQL
 略
### Architecture 架构
 Vitess平台由许多服务器进程，命令行实用程序和基于web的实用程序组成，并由一致的元数据存储提供支持。
 根据您的应用程序的当前状态，您可以通过许多不同的流程实现完整的Vitess实施。例如：如果您要从头开始构建服务，那么使用Vitess的第一步就是定义数据库拓扑。但是，如果您需要扩展现有数据库，则可能首先部署连接代理。
 Vitess工具和服务器旨在为您提供帮助，无论您是从一组完整的数据库开始，还是从小规模开始，随着时间的推移开始扩展。对于较小的实现，连接池和查询重写等vttablet功能可帮助您从现有硬件中获得更多。Vitess的自动化工具为大型实施提供了额外的好处。
 下图说明了Vitess的组件：
 略
- Topology 拓扑
 >该拓扑服务是一个元数据存储，其中包含有关于运行的服务器，分片方案，并复制图形信息。该拓扑由一个一致的数据存储支持。您可以使用vtctl(命令行)和vtctld（web）来浏览拓扑。
 在Kubernetes中，数据库存储是etcd。Vitess源代码还附带Apache ZooKeeper支持。
- vtgate
 >vtgate是一个轻型代理服务器，可将流量路由到正确的vttablet（s）并将合并结果返回给客户端。它是应用程序向其发送查询的服务器。因此，客户端可以非常简单，因为它只需要能够找到一个vtgate实例。
 为了路由查询，vtgate考虑了分片方案，所需的延迟以及水平扩展及其基础MySQL实例的可用性。
- vttablet
 >vttablet是位于MySQL数据库之前的代理服务器。Vitess实现对每个MySQL实例都有一个vttablet。
 vttablet执行的任务是尝试最大化吞吐量，并保护MySQL免受有害查询的影响。其功能包括连接池，查询重写，查询重复。另外vttablet执行vtctl启动的管理任务，并提供用于过滤复制和数据导出的流服务。
- vtctl
  > vtctl是用于管理Vitess集群的命令行工具。它允许人或应用程序轻松地与Vitess实现进行交互。使用vtctl，您可以识别主数据库和副本数据库，创建表，启动故障转移，执行分片（和重新分片）操作等等。
  当vtctl执行操作时，它根据需要更新锁服务器。其他Vitess服务器观察这些变化并作出相应的反应。例如，如果您使用vtctl故障转移到新的主数据库，vtgate会看到更改并将将来的写操作指向新的主数据库。
- vtctld
  >vtctld是一个HTTP服务器，可让您浏览存储在锁定服务器中的信息。这对于故障排除或获取服务器及其当前状态的高级概述很有用。
- vtworker
  >vtworker承载长时间运行的进程。它支持插件架构并提供库，以便您可以轻松选择要使用的平板电脑。插件可用于以下类型的作业：
  - 在分片分割和连接过程中重新划分不同的作业检查数据完整性
  - 垂直分割不同作业检查垂直分割和连接期间的数据完整性
  vtworker还允许您轻松添加其他验证过程。例如，如果一个密钥空间中的索引表引用了另一个密钥空间中的数据，则可以执行内嵌式完整性检查以验证外键类似关系或跨分片完整性检查。
- Other support tools
  Vitess还包含以下工具：
  - mysqltl:管理MySQL实例
  - vtcombo:包含Vitess所有组件的单个二进制文件。它可用于在持续集成环境中测试查询。
  - vtexplain：一种命令行工具，用于探索Vitess如何根据用户提供的模式和拓扑处理查询，而无需设置完整集群。
  - zk：命令行ZooKeeper客户端和资源管理器
  - zkctl：管理ZooKeeper实例

### Vitess on Kubernetes 运行与Kubernetes上的Vitess
Kubernetes是Docker容器的开源协调系统，Vitess可以作为Kubernetes感知的云本地分布式数据库运行。
Kubernetes在计算集群的节点上处理调度，主动管理这些节点上的工作负载，并将包含应用程序的容器分组，以便于管理和发现。这为Vitess在YouTube上运行的前身Kubernetes提供了一个类似的开源环境。
运行Vitess最简单的方法是通过Kubernetes。但是，这不是要求，还会使用其他类型的部署。
### History
略
### Open Source First
略
