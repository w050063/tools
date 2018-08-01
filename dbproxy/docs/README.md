# 全量配置说明
- https://github.com/highras/fpnn/blob/master/doc/conf.template
- https://github.com/highras/dbproxy/blob/master/doc/zh-cn/DBProxy-Configurations.md

# 账号相关
# 部署数据库
请使用DBDeploy操作，具体请参考DBProxy管理工具中，DBDeploy相关内容。

**注意**
- hash分库分表与区段分库选择
> 因为区段分库在运行一段时间后，会导致数据库压力和热点不均匀，因此强烈建议使用 hash 分库分表。

- 检查数据表
> 对于新创建的数据表，请使用 DBTableChecker 或 DBTableStrictChecker 进行检查。

- 新增数据表生效
  - 1、请使用DBDeployer的update config time 命令，更新配置库更新时间。
  - 2、两种方法
    - 等待配置项 DBProxy.ConfigureDB.checkInterval(默认900秒)指定的时间过后，DBProxy自动加载新的数据表。
    - 或使用 DBRefresher强制每个DBProxy立刻加载新的数据表。(./DBRefresher 10.0.0.6:12321 )
# 修改数据表结构
# 框架性能监控
