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

设置教程：https://www.synology.com/zh-cn/knowledgebase/DSM/help/VPNCenter/vpn_setup

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
```
VPN Passthrough是一个用来解决隧道加密数据通过NAT设备的方法。它的典型应用环境有如下两种:
VPN客户端 ------> NAT路由器 ------ Internet ------ VPN服务器
VPN服务器 ------> NAT路由器 ------ Internet ------ VPN 服务器/客户端

第一种情况是你的笔记本或PC通过一台NAT路由器上网，在笔记本或PC上运行相应的VPN客户端软件，建立VPN连接到公司的VPN服务器。

第二种情况是你的VPN服务器通过一台NAT路由器上网，其它分支点的VPN服务器或VPN用户需要建立VPN连接到你的VPN服务器。

VPN Passthrough用来处理加密的IPsec (ESP)或PPTP (GRE)数据包不包含明文源端口和目标端口的情况。ESP是IP protocol 50，GRE是IP protocol 47，它们不像标准的TCP或UDP那样有明确的端口。所以NAT设备不知道如何处理进入的ESP或GRE数据包，或不知道如何为外出的ESP或GRE数据包进行端口转换。打开VPN Passthrough将指导NAT“pass through”这些ESP或GRE数据包。对于外出的ESP或GRE，只进行地址转换及其它一些必要的NAT转换，但不尝试转换端口；对于进入的ESP或GRE数据包，将它们关联到所属的VPN客户端，而不使用端口信息。
```
- L2TP iPhone手机可以联，Win7/Mac Error 809
  - http://koolshare.cn/thread-31253-1-1.html
  - https://vkelk.wordpress.com/2012/10/28/windows-72008-error-809-l2tp-vpn/

## to-do-list
- google chrome插件(Synology Download Station)
- 如何安装docker(需要在官网手动下载安装包安装)
- [监控摄像](https://www.synology.cn/zh-cn/compatibility/camera)
- [闲置 Android 设备做摄像头，在群晖 Surveillance Station 中实现智能监控](https://www.appinn.com/surveillance-station-with-android-ip-camera/)
