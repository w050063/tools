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
### Contents 内容
- MySQL数据库模，这是各个MySQL实例的模式
- VSchema，它表述了所有keyspaces，以及他们的分片

工作流程VSchema如下：
- 使用该ApplyVschema命令为每个密钥空间应用VSchema 。这将VSchemas保存在全局的topo服务器中。
- 执行RebuildVSchemaGraph针对每个小区（或所有细胞）。该命令将组合的VSchema的非规范化版本传播到所有指定的单元格。这种传播的主要目的是最小化每个单元与全局拓扑的依赖关系。只将变化推送到特定单元格的功能可以让您在变更之前确保变化良好，然后将其部署到任意位置。

### Reviewing your schema 检查您的模式
本节介绍vtctl命令，让你查看架构并验证器在tablet或shards上的一致性
- GetSchema

  该命令显示tablet或tablet的子集的完整模式。

- ValidateSchemaShard

  验证是否具有相同的架构

- ValidateSchemaKeyspace

  略
- GetVSchema

  显示指定密钥空间的全局VSchema

- GetSrvVSchema

  显示给定单元格多的组合VSchema

### Changing your schema  改变您的模式
- ApplySchema

  Vitess架构修改功能的设计考虑了以下几个目标：
  - 启动传播到整个服务器的简单更新
  - 最少的人际交往
  - 通过针对临时数据库测试更改来最大限度的减少错误
  - 对于大多数模式更新，确保非常少的停机时间(或无停机时间)
  - 不要在拓扑服务器中存储永久架构数据。

请注意：目前，Vitess仅支持 创建，修改或删除数据库表的数据定义语句。例如，ApplySchema不影响存储过程或赠款。

该ApplySchema 命令将架构更改应用于每台主平板电脑上指定的密钥空间，并行运行在所有碎片上。然后通过复制将更改传播到从服务器。命令格式是： ApplySchema {-sql=<sql> || -sql_file=<filename>} <keyspace>

当该ApplySchema操作实际将模式更改应用于指定的密钥空间时，它将执行以下步骤：
- 它发现属于密钥空间的碎片，包括如果发生重新划分事件时新添加的碎片 。
- 它验证SQL语法并确定模式更改的影响。如果变化的范围太大，Vitess会拒绝它。有关更多详细信息，请参阅允许的模式更改部分
- 它使用飞行前检查来确保在更改实际应用于实时数据库之前模式更新会成功。在这个阶段，Vitess将当前模式复制到临时数据库中，在那里应用更改以验证它，并检索生成的模式。通过这样做，Vitess可以验证更改是否成功，而无需实际接触实时数据库表。
- 它在每个分片中的主平板电脑上应用SQL命令。

以下示例命令将user_table.sql 文件中的SQL应用于用户密钥空间：

> ApplySchema -sql_file=user_table.sql user

**Permitted schema changes** 允许的模式更改

该ApplySchema命令支持一组有限的DDL语句。此外，Vitess拒绝某些模式更改，因为较大的更改会减慢复制速度，并可能降低整个系统的可用性。

以下列表标识了Vitess支持的DDL语句的类型：

- CREATE TABLE
- CREATE INDEX
- CREATE VIEW
- ALTER TABLE
- ALTER VIEW
- RENAME TABLE
- DROP TABLE
- DROP INDEX
- DROP VIEW

此外，Vitess在评估潜在变化的影响时应用以下规则：
- DROP 无论表的大小如何，总是允许使用语句。
- ALTER 只有在分片主平板电脑上的表格具有100,000行或更少的行时才允许使用语句。
- 对于所有其他声明，碎片主平板电脑上的表格必须有200万行或更少。

如果模式更改因为影响太多的行而被拒绝，您可以指定标志来告诉跳过此检查。但是，我们不建议这样做。相反，您应该遵循模式交换流程应用大型模式更改。-allow_long_unavailabilityApplySchema

- ApplyVSchema

  该ApplyVSchema 命令将指定的VSchema应用于密钥空间。VSchema可以被指定为字符串或文件。

- RebuildVSchemaGraph

  该RebuildVSchemaGraph 命令将全局VSchema传播到特定单元格或指定单元格的列表。

### VSchema Guide VSchema 用户指南
#### Contents
VSchema代表Vitess Schema。与包含有关表的元数据的传统数据库模式相比，VSchema包含有关如何在密钥空间和分片中组织表的方式的元数据。简而言之，它包含使Vitess看起来像单个数据库服务器所需的信息。

例如，VSchema将包含关于分片表的分片键的信息。当应用程序使用引用密钥的WHERE子句发出查询时，将使用VSchema信息将查询路由到适当的分片。
#### Sharding Model 分片模型
在Vitess中，a keyspace被keyspace ID范围分割。每行都被分配一个密钥空间ID，这个密钥空间ID就像街道地址一样，它决定了该行所在的分片。在某些方面，可以说这keyspace ID相当于NoSQL分片密钥。但是，有一些差异：

- 这keyspace ID是Vitess内部的一个概念。该应用程序不需要知道任何有关它。
- 没有存储实际的物理列keyspace ID。该值根据需要进行计算。

这种差异足够重要，我们不把密钥空间ID称为分片密钥。我们稍后将介绍主要Vindex的概念，它更紧密地重新排列NoSQL分片密钥。

映射到keyspace ID碎片，然后映射到碎片，使我们能够灵活地重新保存数据，同时keyspace ID保持最小的中断，因为每行的数据在整个过程中保持不变。
#### Vindex
- The Primary Vindex
- Secondary Vindexes
- Unique and NonUnique Vindex
- Functional and Lookup Vindex
- Shared Vindexes
- Orthogonality
- How vindexes are used
- Predefined Vindexes
#### Sequences
#### VSchema
- Unsharded Table
- Sharded Table With Simple Primary Vindex
- Specifying A Sequence
- Specifying A Secondary Vindex
- Advanced usage
#### Roadmap

### Schema Swap (Tutorial)  架构交互（教程）
#### Contents 内容
本节描述如何在不中断正在进行的操作的情况下，在Vitess / MySQL中应用长时间运行的模式更改。大型数据库长时间运行更改ALTER TABLE的示例（例如添加列）OPTIMIZE TABLE或大规模数据更改（例如填充列或清除值）。

如果模式更改不是长时间运行的，请改用更简单的vtctl ApplySchema。
#### Overview 概述

#### Prerequisites 先决条件
#### Schema Swap Steps

## Sharding 拆分
### Horizontal Sharding (Tutorial, automated) 水平分片（教程、自动化）
#### Contents 内容
  本节向您展示如果使用水平重用工作流程在现有未分散Vitess密钥空间中应用基于范围的分片过程的示例。在这个案例中，我们将从1个shard重新生成2个shard.

#### Overview 概述

#### Prerequisites 先决条件
您应该完成入门教程(请在尝试Vitess重新划分之前完成所有步骤)，并且已经离开集群运行。然后在运行重新分片过程之前按照如下步骤操作：
- 1、配置分片信息
  > vitess/examples/local$ ./lvtctl.sh ApplyVSchema -vschema "$(cat vschema.json)" test_keyspace

- 2、为2个附加shard启动tablet：test_keyspace/-80和test_keyspace/80-
  > vitess/examples/local$ ./sharded-vttablet-up.sh

  通过选择每个新分片的第一个主分区来初始化复制
  > vitess/examples/local$ ./lvtctl.sh InitShardMaster -force test_keyspace/-80 test-200
    vitess/examples/local$ ./lvtctl.sh InitShardMaster -force test_keyspace/80- test-300

  设置完成后，您应该在vtctld UI（http：// localhost：15000）的仪表板页面上看到分片。应该有一个名为“0”的服务分片和两个名为“-80”和“80-”的非服务分片。点击分片节点，您可以检查其所有平板电脑信息。
- 3、弹出一个vtworker过程中，可通过端口15033.连接（数量vtworker应该是相同的原始碎片，我们在这里开始一个vtworker的过程，因为我们只有一个在这个例子中原来的碎片。）
  > vitess/examples/local$ ./vtworker-up.sh

  您可以验证通过http://192.168.47.100:15032/Debugging设置的vtworker进程。它应该成功。在ping完vtworker之后，请点击“重置作业”。否则，vtworker没有准备好执行其他任务。

#### Horizontal resharding workflow 水平重新划分工作流程

##### Create the workflow 创建工作流程
- 1、打开vtctld UI(http://localhost:15000)左侧菜单中的工作流程部分。点击右上角的+按钮打开Create a new Workflow对话框
- 2、按照以下说明填写创建新工作流对话框（查看实例）
  - 如果您不想在创建后立即启动工作流，请选中“跳过开始”复选框。如果是这样，您需要稍后单击工作流栏中的“开始”按钮以运行工作流程。
  - 打开“Factory Name”菜单并选择“Horizo​​ntal Resharding”。该字段定义您要创建的工作流的类型。
  - 在“Keyspace”插槽中填写test_keyspace。
  - 在“vtworker地址”插槽中填入localhost：15033。
  - 如果您不想手动批准加拿大的任务执行，请取消选中“enable_approvals”复选框。（我们建议您保留默认选择的选项，因为这将启用金丝雀功能）
- 3、点击对话框底部的“创建”按钮。如果创建成功，您将在Workflows页面中看到一个工作流程节点。如果未选择“跳过开始”，工作流程现在开始运行。

启动工作流程的另一种方式是通过vtctlclient命令，在执行命令之后，您还可以在vtctld UI 工作流程部分可视化工作流程：

> vitess/examples/local$ ./lvtctl.sh WorkflowCreate -skip_start=false horizontal_resharding -keyspace=test_keyspace -vtworkers=localhost:15033 -enable_approvals=true

创建重新分片工作流程时，程序会自动检测源分片和目标分片，并为重新分片过程创建任务。创建完成后，单击工作流节点，即可看到子节点列表。每个子节点代表工作流中的一个阶段（每个阶段代表概述中提到的一个步骤）。进一步点击一个阶段节点，你可以在这个阶段检查任务。例如，在“CopySchemaShard”阶段，它包括将模式复制到2个目标碎片的任务，因此您可以看到任务节点“碎片-80”和“碎片80-”。你应该看到一个类似这样的页面 。

##### Approvals of Tasks Execution (Canary feature) 任务执行的批准（Canary功能）
一旦工作流程开始运行（如果选择了“跳过开始”并且工作流还未开始，请单击“开始”按钮），如果选择“enable_approvals”，则需要批准每个阶段的任务执行。批准包括2个阶段。第一阶段只批准第一项任务，即运行的第一项任务。第二阶段批准剩下的任务。

重新分片工作流程按顺序进行。阶段开始后，您可以看到阶段节点下所有阶段的审批按钮（如果您没有看到审批按钮，请点击阶段节点，您应该看到类似这样的页面）。当相应的任务准备好运行时，该按钮被启用。点击启用按钮以批准任务执行，然后您可以在点击的按钮上看到批准的消息。阶段完成后，审批按钮将被清除。下一阶段只有在前一阶段成功完成时才会开始。

如果工作流程已从检查点恢复，那么在此许可下有正在运行的任务时，您仍然会看到带有批准消息的审批按钮。但是，您不需要为重新启动的工作流再次批准相同的任务。

##### Retry
如果任务失败，将在任务节点下启用“重试”按钮（如果作业卡住但没有看到“重试”按钮，请单击任务节点）。如果您修复了错误并想重试失败的任务，请单击此按钮。如果任务连续失败，您可以根据需要多次重试。修复后，工作流程可以从故障点继续进行。

例如，您可能会忘记启动一个vtworker进程。需要在SplitClone阶段执行vtworker进程的任务将失败。解决此问题后，单击任务节点上的重试按钮，工作流程将继续运行。

当任务失败时，如果此阶段并行运行任务（应用于“CopySchemaShard”，“SplitClone”，“WaitForFilteredReplication”阶段），则此阶段执行的其他任务不会受到影响。对于按顺序运行任务的阶段，此阶段剩余的未启动任务将不会执行很长时间。之后的阶段将不再执行。

##### Checkpoint and Recovery 检查点和恢复
重新分片工作流跟踪每个任务的状态，并在状态更新时将这些状态检查点转换为拓扑服务器。通过在拓扑中加载检查点来停止并重新启动工作流时，它可以继续运行所有未完成的任务。

#### Verify Results and Clean up  验证结果并清理
在重新分片过程之后，原始分片中的数据被完全复制到新的分片中。数据更新将在新分片中显示，但不会显示在原始分片上。然后，您应该在vtctld UI Dashboard页面中看到分片 0变为非分配，而分片-80和分片80-正在分配分片。自己验证一下：使用以下命令检查数据库内容，然后将消息添加到留言簿页面（您可以使用此处提到的脚本client.sh ）并使用相同的命令进行检查：
``` bash
# See what's on shard test_keyspace/0
# (no updates visible since we migrated away from it):
vitess/examples/local$ ./lvtctl.sh ExecuteFetchAsDba test-100 "SELECT * FROM messages"
# See what's on shard test_keyspace/-80:
vitess/examples/local$ ./lvtctl.sh ExecuteFetchAsDba test-200 "SELECT * FROM messages"
# See what's on shard test_keyspace/80-:
vitess/examples/local$ ./lvtctl.sh ExecuteFetchAsDba test-300 "SELECT * FROM messages"
```
您也可以在vtctl UI上签出拓扑浏览器。它向您显示分片关键字的信息及其服务状态。每个碎片应该看起来像这样
shard 0

shard -80

shard 80-

验证结果后，我们可以删除原始分片，因为所有流量都是从新分片提供的：

> vitess/examples/local$ ./vttablet-down.sh

然后，我们可以删除现在为空的分片：

> vitess/examples/local$ ./lvtctl.sh DeleteShard -recursive test_keyspace/0
然后，您应该在vtctld UI 仪表板页面中看到分片0消失。
#### Tear down and clean up
由于您已经通过运行从原始未展开的示例中清除了平板电脑，因此已将该步骤替换 为清理新的分片平板电脑。./vttablet-down.sh./sharded-vttablet-down.sh
``` bash
vitess/examples/local$ ./vtworker-down.sh
vitess/examples/local$ ./vtgate-down.sh
vitess/examples/local$ ./sharded-vttablet-down.sh
vitess/examples/local$ ./vtctld-down.sh
vitess/examples/local$ ./zk-down.sh
```

#### Reference 参考
- Details in SplitClone phase  SplitClone阶段详细信息
- Details in WaitForFilteredReplication phase WaitForFilteredReplication阶段详细信息
- Details in MigrateServedTypeMaster phase MigrateServedTypeMaster阶段详细信息

### Horizontal Sharding (Tutorial, manual) 水平分片（教程、手册）
#### Contents 内容
  本节内容指导您分解现有的unsharded Vitess keyspace.

#### Prerequisites 先决条件
  首先假设您已经完成入门指南，并且已经使集群运行起来。

#### Overview 概述
  该文件夹中的示例客户端使用如下模式：example/local
  ``` sql
  CREATE TABLE messages (
  page BIGINT(20) UNSIGNED,
  time_created_ns BIGINT(20) UNSIGNED,
  message VARCHAR(10000),
  PRIMARY KEY (page, time_created_ns)
  ) ENGINE=InnoDB
  ```
这个想法是，每个页面号代表多租户应用程序中的单独留言簿。每个留言页面都包含一个消息列表。

在本指南中，我们将介绍按页码进行分片。这意味着页面将随机分布在各个分片中，但给定页面的所有记录始终保证位于同一个分片上。通过这种方式，我们可以透明地扩展数据库以支持页数的任意增长。
#### Configure sharding information 配置分片信息
第一步是告诉Vitess我们如何分割数据。我们通过提供VSchema定义来完成此操作，如下所示：
``` json
{
  "sharded": true,
  "vindexes": {
    "hash": {
      "type": "hash"
    }
  },
  "tables": {
    "messages": {
      "column_vindexes": [
        {
          "column": "page",
          "name": "hash"
        }
      ]
    }
  }
}
```
这表示我们希望通过page列的散列碎片来分割数据。换句话说，将每个页面的消息保存在一起，但随机地在页面周围扩展页面。

我们可以像这样将这个VSchema加载到Vitess中：

> vitess/examples/local$ ./lvtctl.sh ApplyVSchema -vschema "$(cat vschema.json)" test_keyspace


#### Bring up tablets for new shards 为新的shards应用新的tablets
在unsharded例子，你开始平板电脑名为碎片0在test_keyspace，写成test_keyspace / 0。现在，您将开始为两个额外的碎片启动平板电脑，名为test_keyspace / -80和test_keyspace / 80-：

> vitess/examples/local$ ./sharded-vttablet-up.sh
由于分片键是页码，因此0x80是分片键范围的中点 ，这将导致一半页面到达每个分片。

这些新的分片将在转换过程中与原始分片并行运行，但实际流量只能由原始分片提供，直到我们告诉它切换。

检查vtctld Web用户界面或其输出，以查看平板电脑何时准备就绪。每个碎片应该有5片。lvtctl.sh ListAllTablets test

平板电脑准备好后，通过选择每个新分片的第一个主分区来初始化复制：
``` bash
vitess/examples/local$ ./lvtctl.sh InitShardMaster -force test_keyspace/-80 test-0000000200
vitess/examples/local$ ./lvtctl.sh InitShardMaster -force test_keyspace/80- test-0000000300
```
现在应该总共有15个平板电脑，每个分片有一个主人：
``` bash
vitess/examples/local$ ./lvtctl.sh ListAllTablets test
### example output:
# test-0000000100 test_keyspace 0 master 10.64.3.4:15002 10.64.3.4:3306 []
# ...
# test-0000000200 test_keyspace -80 master 10.64.0.7:15002 10.64.0.7:3306 []
# ...
# test-0000000300 test_keyspace 80- master 10.64.0.9:15002 10.64.0.9:3306 []
# ...
```

#### Copy data from original shard 从原始分片复制数据
新的平板电脑开始是空的，因此我们需要将所有内容从原始分片复制到两个新分片，从模式开始：
``` bash
vitess/examples/local$ ./lvtctl.sh CopySchemaShard test_keyspace/0 test_keyspace/-80
vitess/examples/local$ ./lvtctl.sh CopySchemaShard test_keyspace/0 test_keyspace/80-
```
接下来我们复制数据。由于要复制的数据量可能非常大，因此我们使用称为vtworker的特殊批处理过程将数据从单个源流式传输到多个目标，并根据其keyspace_id路由每行 ：
``` bash
vitess/examples/local$ ./sharded-vtworker.sh SplitClone test_keyspace/0
### example output:
# I0416 02:08:59.952805       9 instance.go:115] Starting worker...
# ...
# State: done
# Success:
# messages: copy done, copied 11 rows
```
请注意，我们只指定了源分片test_keyspace / 0。该SplitClone过程中会自动计算出基于需要被覆盖的键范围的目的地使用的碎片。在这种情况下，分片0覆盖整个范围，因此它将-80和80标识 为目标分片，因为它们结合覆盖相同的范围。

接下来，它将暂停一个rdonly（离线处理）平板电脑上的复制，以充当数据的一致快照。应用程序可以继续运行而无需停机，因为实时流量由不受影响的副本和主平板电脑提供。其他批处理作业也将不受影响，因为它们将仅由剩余的未暂停rdonly平板电脑提供服务。

#### Check filtered replication
#### Check copied data integrity
#### Switch over to new shards
#### Remove original shard
#### Tear down and clean up

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
