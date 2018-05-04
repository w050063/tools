# vtctl
官网地址：https://vitess.io/reference/vtctl/
## Contents
  本文档描述了Vitess API方法，使您的客户端应用程序能够轻松的与您的存储系统对话以查询数据。API方法分为以下几类：

- Cells
- Generic
- Keyspaces
- Queries
- Replication Graph
- Resharding Throttler
- Schema, Version, Permissions
- Serving Graph
- Shards
- Tablets
- Topo
- Workflows

vtctld、vtctl、vtctlclient三者之间的关系
- vtctld
  守护进程
- vtctl
  不需要vtctld守护进程，它需要从topology之间获取信息
- vtctlclient
  vtctlclient 需要vtctld的存在才能进行相应的操作 需要-server 指向vtctld的端口

## Cells
  - AddCellInfo
  - DeleteCellInfo
  - GetCellInfo
  - GetCellInfoNames
  - UpdateCellInfo

``` bash
cd /data0/workspaces/go/src/vitess.io/vitess/examples/local
./lvtctl.sh AddCellInfo cell-loveworld
./lvtctl.sh DeleteCellInfo first
./lvtctl.sh GetCellInfo test
{
  "server_address": "localhost:21811,localhost:21812,localhost:21813",
  "root": "/vitess/test",
  "region": ""
}
./lvtctl.sh GetCellInfoNames
cell-loveworld
test
./lvtctl.sh UpdateCellInfo test
```

## Generic 通用
  - ListAllTablets
  - ListTablets
  - Validate

``` bash
./lvtctl.sh ListAllTablets test
test-0000000100 test_keyspace 0 master 192.168.47.100:15100 192.168.47.100:17100 []
test-0000000101 test_keyspace 0 restore 192.168.47.100:15101 192.168.47.100:17101 []
test-0000000102 test_keyspace 0 restore 192.168.47.100:15102 192.168.47.100:17102 []
test-0000000103 test_keyspace 0 restore 192.168.47.100:15103 192.168.47.100:17103 []
test-0000000104 test_keyspace 0 restore 192.168.47.100:15104 192.168.47.100:17104 []
./lvtctl.sh ListTablets test-100
test-0000000100 test_keyspace 0 master 192.168.47.100:15100 192.168.47.100:17100 []
./lvtctl.sh Validate
```
## Keyspaces
  - CreateKeyspace
  - DeleteKeyspace
  - FindAllShardsInKeyspace
  - GetKeyspace
  - GetKeyspaces
  - MigrateServedFrom
  - MigrateServedTypes
  - RebuildKeyspaceGraph
  - RemoveKeyspaceCell
  - SetKeyspaceServedFrom
  - SetKeyspaceShardingInfo
  - ValidateKeyspace
  - WaitForDrain

``` bash
./lvtctl.sh CreateKeyspace loveworld_keyspace
 ./lvtctl.sh DeleteKeyspace loveworld_keyspace  // 遍历所有的cell
W0504 18:28:40.842436   33900 main.go:58] W0504 10:28:40.841252 keyspace.go:891] Cannot delete KeyspaceReplication in cell cell-loveworld for loveworld_keyspace: no valid address found in
W0504 18:28:46.153529   33900 main.go:58] W0504 10:28:46.151431 keyspace.go:895] Cannot delete SrvKeyspace in cell cell-loveworld for loveworld_keyspace: no valid address found in
W0504 18:28:47.578951   33900 main.go:58] W0504 10:28:47.578291 keyspace.go:891] Cannot delete KeyspaceReplication in cell d for loveworld_keyspace: no valid address found in
W0504 18:28:52.813035   33900 main.go:58] W0504 10:28:52.812128 keyspace.go:895] Cannot delete SrvKeyspace in cell d for loveworld_keyspace: no valid address found in
./lvtctl.sh FindAllShardsInKeyspace test_keyspace
{
  "0": {
    "master_alias": {
      "cell": "test",
      "uid": 100
    },
    "served_types": [
      {
        "tablet_type": 1
      },
      {
        "tablet_type": 2
      },
      {
        "tablet_type": 3
      }
    ],
    "cells": [
      "test"
    ]
  }
}
./lvtctl.sh GetKeyspace loveworld_keyspace
{
  "sharding_column_name": "",
  "sharding_column_type": 0,
  "served_froms": [
  ]
}
./lvtctl.sh GetKeyspaces
test_keyspace
```

## Queries
  - VtGateExecute
  - VtGateExecuteKeyspaceIds
  - VtGateExecuteShards
  - VtGateSplitQuery
  - VtTabletBegin
  - VtTabletCommit
  - VtTabletExecute
  - VtTabletRollback
  - VtTabletStreamHealth
  - VtTabletUpdateStream

``` bash
```
## Replication Graph
- GetShardReplication

``` bash
./lvtctl.sh GetShardReplication test test_keyspace/0
{
  "nodes": [
    {
      "tablet_alias": {
        "cell": "test",
        "uid": 102
      }
    },
    {
      "tablet_alias": {
        "cell": "test",
        "uid": 101
      }
    },
    {
      "tablet_alias": {
        "cell": "test",
        "uid": 100
      }
    },
    {
      "tablet_alias": {
        "cell": "test",
        "uid": 103
      }
    },
    {
      "tablet_alias": {
        "cell": "test",
        "uid": 104
      }
    }
  ]
}
```
## Resharding Throttler
- GetThrottlerConfiguration
- ResetThrottlerConfiguration
- ThrottlerMaxRates
- ThrottlerSetMaxRate
- UpdateThrottlerConfiguration

Schema, Version, Permissions
ApplySchema
ApplyVSchema
CopySchemaShard
GetPermissions
GetSchema
GetVSchema
RebuildVSchemaGraph
ReloadSchema
ReloadSchemaKeyspace
ReloadSchemaShard
ValidatePermissionsKeyspace
ValidatePermissionsShard
ValidateSchemaKeyspace
ValidateSchemaShard
ValidateVersionKeyspace
ValidateVersionShard
Serving Graph
GetSrvKeyspace
GetSrvKeyspaceNames
GetSrvVSchema
Shards
CreateShard
DeleteShard
EmergencyReparentShard
GetShard
InitShardMaster
ListBackups
ListShardTablets
PlannedReparentShard
RemoveBackup
RemoveShardCell
SetShardServedTypes
SetShardTabletControl
ShardReplicationFix
ShardReplicationPositions
SourceShardAdd
SourceShardDelete
TabletExternallyReparented
ValidateShard
WaitForFilteredReplication
Tablets
Backup
ChangeSlaveType
DeleteTablet
ExecuteFetchAsDba
ExecuteHook
GetTablet
IgnoreHealthError
InitTablet
Ping
RefreshState
RefreshStateByShard
ReparentTablet
RestoreFromBackup
RunHealthCheck
SetReadOnly
SetReadWrite
Sleep
StartSlave
StopSlave
UpdateTabletAddrs
Topo
TopoCat
Workflows
WorkflowAction
WorkflowCreate
WorkflowDelete
WorkflowStart
WorkflowStop
WorkflowTree
WorkflowWait
