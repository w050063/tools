# 群晖相关知识总结
## 配置LDAP
## 设置权限
## 日常管理
- [磁盘分析报告](https://www.synology.com/zh-cn/knowledgebase/DSM/help/StorageAnalyzer/StorageAnalyzer_desc)

   报告存放位置(可设置)：/volume1/xxxxx/Storage Analyzer/synoreport

   显示系统变量 echo $HOSTNAME

   系统目录
   - /var/packages/StorageAnalyzer
   - /usr/syno/etc/packages/StorageAnalyzer

   通知设置
- Directory Server
https://www.synology.com/zh-cn/knowledgebase/DSM/help/DirectoryServer/ldap_desc
- Git Server
https://blog.csdn.net/kaulctin/article/details/68080043

## FQA
- 设置自定义服务开机启动

> 控制面板-->任务计划-->新增-->事件选择开机-->配置服务启动脚本即可

- 磁盘检查URL错误，无法访问

> 编写自定义脚本-->添加定时任务
