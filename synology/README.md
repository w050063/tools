# 群晖相关知识总结
## 选购
- 配置
- 硬盘
## 安装配置
- 安装系统
- 网络设置
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
## VPN
### L2TP

认证方式支持
- PAP
- MS-CHAP v2

```
/usr/syno/etc/packages/VPNCenter/
/var/packages/VPNCenter/target/sbin/vpnauthd -t
/usr/sbin/xl2tpd -c /usr/syno/etc/packages/VPNCenter/l2tp/xl2tpd.conf -p /var/run/xl2tpd.pid
cat /usr/syno/etc/packages/VPNCenter/l2tp/options.xl2tpd

https://forum.huawei.com/enterprise/en/thread-411139-1-1.html

display interface Virtual-PPP 0

require-mschap-v2
refuse-mschap
refuse-chap
refuse-pap
```

## to-do-list
- google chrome插件(Synology Download Station)
- 如何安装docker(需要在官网手动下载安装包安装)
- [监控摄像](https://www.synology.cn/zh-cn/compatibility/camera)
- [闲置 Android 设备做摄像头，在群晖 Surveillance Station 中实现智能监控](https://www.appinn.com/surveillance-station-with-android-ip-camera/)
