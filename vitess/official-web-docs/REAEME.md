# Vitess官网文档总结
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
 该拓扑服务是一个元数据存储，其中包含有关于运行的服务器，分片方案，并复制图形信息。该拓扑由一个一致的数据存储支持。您可以使用vtctl(命令行)和vtctld（web）来浏览拓扑。
 在Kubernetes中，数据库存储是etcd。Vitess源代码还附带Apache ZooKeeper支持。
- vtgate 
 vtgate是一个轻型代理服务器，可将流量路由到正确的vttablet（s）并将合并结果返回给客户端。它是应用程序向其发送查询的服务器。因此，客户端可以非常简单，因为它只需要能够找到一个vtgate实例。
 为了路由查询，vtgate考虑了分片方案，所需的延迟以及水平扩展及其基础MySQL实例的可用性。
- vttablet
 vttablet是位于MySQL数据库之前的代理服务器。Vitess实现对每个MySQL实例都有一个vttablet。
 vttablet执行的任务是尝试最大化吞吐量，并保护MySQL免受有害查询的影响。其功能包括连接池，查询重写，查询重复。另外vttablet执行vtctl启动的管理任务，并提供用于过滤复制和数据导出的流服务。
- vtctl
- vtctld
- vtworker
- Other support tools
### Vitess on Kubernetes
### History
### Open Source First

### What is Vitess 什么是Vitess
### Scaling MySQL with Vitess 用Vitess扩展MySQL
### Key Concepts  关键概念
