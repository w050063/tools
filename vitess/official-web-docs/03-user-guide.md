# User Guide 用户指南
## Introduction 介绍
### Contents
### Platform support 平台支持

  我们不断测试Ubuntu 14.04（Trusty）和Debian 8（Jessie）。其他Linux发行版也应该可以工作。
### Database support 数据库支持

  Vitess支持MySQL 5.6， MariaDB 10.0以及MySQL 5.7等新版本.Vitess还支持Percona对这些版本的变体。

  - Relational capabilities 关系能力

    Vitess试图充分利用底层MySQL实例的功能。在这方面，任何可以传递给单个密钥空间，碎片或碎片集的查询将按原样发送到MySQL服务器。

    只要关系和约束位于一个分片（或未分片的密钥空间）内，这种方法就可以利用MySQL的全部功能。

    对于超越碎片关系，Vitess提供通过支持VSchema。

  - Schema management 模式管理

    Vitess支持多种功能，用于查看您的架构并验证片段中的平板电脑或密钥空间中的所有碎片之间的一致性。

    另外，Vitess支持 创建，修改或删除数据库表的数据定义语句。Vitess在每个分片中的主平板电脑上执行模式更改，然后这些更改通过复制传播到从属平板电脑。Vitess不支持其他类型的DDL语句，例如影响存储过程或授权的DDL语句。

    在执行模式更改之前，Vitess将验证SQL语法并确定更改的影响。它还会进行飞行前检查以确保可以将更新应用于您的模式。此外，为了避免降低整个系统的可用性，Vitess拒绝超出特定范围的更改。

    有关 更多信息，请参阅本指南的“ 架构管理”部分。

### Supported clients 支持的客户端

  VTGate服务器是应用程序用于连接Vitess的主要入口点。

  VTGate了解MySQL二进制协议。因此，任何可以直接与MySQL交谈的客户端也可以使用Vitess。

  另外，VTGate通过支持多种语言的gRPC API 公开其功能 。

  通过gRPC访问Vitess比MySQL协议有一些小优点：
  - 您可以使用绑定变量发送请求，这比构建全文查询稍有效率和安全。
  - 你可以利用连接的无状态。例如，您可以使用一台VTGate服务器启动事务，然后使用另一台VTGate服务器完成事务。

  Vitess目前为Java（JDBC）和Go（数据库/ sql）提供基于gRPC的连接器。所有其他人都可以使用本地MySQL驱动程序。Java和Go的本地MySQL驱动程序也应该可以工作。

### Backups

  Vitess支持将数据备份到网络挂载（例如NFS）或BLOB存储。备份存储通过可插拔界面实现，目前我们有Google Cloud Storage，Amazon S3和Ceph可用的插件。

  有关使用Vitess创建和恢复数据备份的更多信息，请参阅本指南的备份数据部分。

## Backing Up Data  备份数据
### Contents 内容
  本文档介绍如何使用Vitess创建和恢复数据备份。Vitess使用备份有两个目的：
  - 提供数据的时间点备份
  - 在现有shard中创建新数据
### Prerequisites 先决条件

Vitess将数据备份存储在备份存储服务上，这是一个可插拔的接口。

目前，我们支持如下插件：
  - A network-mounted path (e.g. NFS)
  - Google Cloud Storage
  - Amazon S3
  - Ceph

在备份和恢复tablet之前，你需要确保tablet知道您正在是的备份存储系统。为此，请在动可访问存储备份位置的vttablet时使用以下命令行标识。

> 略

#### Authentication 认证

请注意：对于Google Cloud Storage插件，我们目前仅支持 应用程序默认凭证。这意味着，由于您已经在Google Compute Engine或Container Engine中运行，因此可以自动授予对云存储的访问权限。

为此，必须使用授予对云存储的读写访问权的范围创建GCE实例。使用Container Engine时，您可以通过添加--scopes storage-rw到gcloud container clusters create命令中来 创建它创建的所有实例，如Kubernetes指南上的Vitess所示。

### Creating a backup 创建备份
运行以下vtctl命令创建备份：
> vtctl Backup <tablet-alias>

执行如下操作：

  - 1、将其类型切换为BACKUP,完成此步骤后，tablet将不再由vtgate提供任何查询
  - 2、停止复制，获取当前复制位置(与数据一起保存在备份中)
  - 3、关闭其mysqld进程
  - 4、将必要的文件复制到tablet启动时指定的备份存储设备。请注意，如果此操作失败，我们仍会继续操作，所以tablet不会因为存储故障而处于不稳定的状态
  - 5、重新启动mysqld
  - 6、将其切换回原来的类型。在此之后，它很可能会落后于复制，并且不会被vtgate用于服务，直到数据同步完成。

### Restoring a backup 恢复备份
tablet启动时，Vitess会检查-restore_from_backup命令行标志的值，以确定是否将备份还原到该tablet.
  - 如果标志存在，Vitess尝试在启动tablet时从备份系统恢复最新的备份
  - 如果标志不存在，Vitess不会尝试将备份恢复到tablet，这相当于在新的分片中启动新的tablet

正如前提条件部分所述，该标志通常在碎片中的所有平板电脑上始终处于启用状态。如果Vitess在备份存储系统中找不到备份，它就会将vttablet作为新的平板电脑启动。
``` bash
vttablet ... -backup_storage_implementation=file \
             -file_backup_storage_root=/nfs/XXX \
             -restore_from_backup
```
### Managing backups 管理备份
vtctl提供两个用于管理备份的命令：

- listbackups按照时间顺序显示现有备份
> vtctl ListBackups <keyspace/shard>

- removebackup删除指定备份
> RemoveBackup <keyspace/shard> <backup name>

### Bootstrapping a new tablet 初始化新tablet
初始化新tablet与恢复现有tablet几乎完全相同。唯一需要注意的tablet在拓扑中注册自己时指定了它的密钥空间，分片和tablet类型。具体而言，确保设置了以下vttablet参数：
``` bash
-init_keyspace <keyspace>
-init_shard <shard>
-init_tablet_type replica|rdonly
 ```
自动tablet将从备份中恢复数据，然后通过重新启动复制来应用备份后发生的更改。

### Backup Frequency 备份频率
我们建议定期备份，例如你应该为它设置一个cron作业。

要确定创建备份的正确频率，请考虑保留复制日志的时间量，并在备份操作失败的情况下留出足够的时间来调查和解决问题。

例如，假设您通常保留四天的复制日志，并创建每日备份。在这种情况下，即使备份失败，您至少需要等待几天时间才能调查并解决问题。
### Concurrency 并发
备份和恢复过程同时复制并压缩或解压缩多个文件以提高吞吐量。您可以使用命令行标志控制并发性：

- vtctl Backup命令使用该 -concurrency标志。
- vttablet使用该-restore_concurrency标志。

如果网络链接足够快，则并发性与备份或还原过程中进程的CPU使用率相匹配。
## Reparenting 重排根
### Contents 内容
Reparenting是将master tablet从一台主机 更改为另一台主机的过程，或更改slave tablet以拥有不同主机的过程。重新手动可以手动启动，也可以根据特定的数据库条件自动发生。作为案例，您可能会在维护练习期间修复shard or tablet,或者在master tablet死亡时自动触发重新设置。

本文档解释了Vitess支持的重新配置类型：
- 当Vitess工具链管理整个重建过程时会发生主动重新映射
- 当另一个工具处理重新配置过程时，外部重新配置会发生，而Vitess工具链只是更新其拓扑服务器，复制图和服务图以准确反映主从关系。

注意：该InitShardMaster命令定义分片中的初始父母关系。该命令将指定的tablet作为主设备，并将其他tablet设置为从该主设备复制的分区从设备。
### MySQL requirements MySQL要求
- GTIDs
Vitess需要为其操作使用全局事务标识符（GTID）：

  - 在主动重新配置的过程中，Vitess使用GTID来初始化复制过程，然后在重新配置时依赖于GTID流。（-在外部重新设置期间，Vitess假定外部工具管理复制过程。）
  - 在重新划分期间，Vitess使用GTID进行过滤复制，即将平板电脑数据传输到适当的目标平板电脑的过程。

- Semisynchronous replication 半同步复制

Vitess不依赖于 半同步复制，但是如果它被实现则可以工作。较大的Vitess部署通常会执行半同步复制。

### Active Reparenting 主动重新租赁
您可以使用以下vtctl 命令执行重新配置操作：

- PlannedReparentShard
- EmergencyReparentShard

这两个命令都锁定全局拓扑服务器中的碎片记录。这两个命令不能并行运行，也不能与命令并行运行 InitShardMaster。

这两个命令都依赖于全局拓扑服务器可用，并且它们都在拓扑服务器的_vt.reparent_journal表中插入行 。因此，您可以通过检查该表来检查数据库的重新备份历史记录。

- PlannedReparentShard: Planned reparenting
- EmergencyReparentShard: Emergency reparenting

### External Reparenting
### Fixing Replication

## Schema Management 模式管理
### Contents
### Reviewing your schema
- GetSchema
- ValidateSchemaShard
- ValidateSchemaKeyspace
- GetVSchema
- GetSrvVSchema
### Changing your schema
- ApplySchema
- ApplyVSchema
- RebuildVSchemaGraph

### VSchema Guide VSchema指南
### Schema Swap (Tutorial)  架构交互（教程）
## Sharding 拆分
### Horizontal Sharding (Tutorial, automated) 水平分片（教程、自动化）
### Horizontal Sharding (Tutorial, manual) 水平分片（教程、手册）
### Sharding in Kubernetes (Tutorial, automated) Kubernetes中分片（教程、自动化）
### Sharding in Kubernetes (Tutorial, manual) Kubernetes中分片（教程、手册）
## Topology Service 拓扑服务
## Transport Security Model 传输安全模型
## Launching  发射
### Scalability Philosophy  可扩展性哲学
### Production Planning 计划生产
### Server Configuration  服务器配置
### 2PC Guide 2PC指南
### Troubleshooting 故障排除
## Upgrading 升级
