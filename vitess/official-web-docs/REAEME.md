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

Vitess vs. Vanilla MySQL
Vitess vs. NoSQL
Architecture
Topology
vtgate
vttablet
vtctl
vtctld
vtworker
Other support tools
Vitess on Kubernetes
History
Open Source First

### What is Vitess 什么是Vitess
### Scaling MySQL with Vitess 用Vitess扩展MySQL
### Key Concepts  关键概念
