> http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html

# Purpose 目的
本文档介绍如何设置和配置单节点Hadoop安装，以便您可以使用Hadoop MapReduce和Hadoop分布式文件系统（HDFS）快速执行简单操作。
# Prerequisites 先决条件
## Supported Platforms 支持的平台
- Linux平台
- Windows平台
## Required Software 必备软件
- Java oracle 1.7.0_45  https://wiki.apache.org/hadoop/HadoopJavaVersions
- 安装ssh并运行sshd
## Installing Software 安装软件
- ssh
- rsync
# Download 下载
# Prepare to Start the Hadoop Cluster 准备启动Hadoop集群
```
# /usr/local/hadoop-2.9.1/bin/hadoop version
Hadoop 2.9.1
Subversion https://github.com/apache/hadoop.git -r e30710aea4e6e55e69372929106cf119af06fd0e
Compiled by root on 2018-04-16T09:33Z
Compiled with protoc 2.5.0
From source with checksum 7d6d2b655115c6cc336d662cc2b919bd
This command was run using /usr/local/hadoop-2.9.1/share/hadoop/common/hadoop-common-2.9.1.jar
```
三种模式：
- Local (Standalone) Mode 本地(独立)模式
- Pseudo-Distributed Mode 伪分布式模式
- Fully-Distributed Mode 完全分布式模式
# Standalone Operation 独立操作

# Pseudo-Distributed Operation 伪分布式操作
## Configuration 配置

## Setup passphraseless ssh 设置
## Execution 执行
## YARN on a Single Node YARN在单节点上
## Fully-Distributed Operation 全分布式操作
