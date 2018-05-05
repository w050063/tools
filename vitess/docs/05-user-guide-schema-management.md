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
