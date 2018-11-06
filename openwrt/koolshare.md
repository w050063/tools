# KoolShare

# U盘安装部署说明
- 下载软件win32diskimager
- 下载固件openwrt-koolshare-mod-v2.22-r8838-af7317c5b6-x86-64-combined-squashfs.img.gz
- 设置启动盘
- 华硕电脑ESC设置U盘启动
- 设置PC地址设置连接路由器默认WEB 192.168.1.1 用户名 root 密码 koolshare

系统安装
- 下载软件physdiskwrite写盘工具,官网:http://m0n0.ch/wall/physdiskwrite.php
- [下载镜像](http://firmware.koolshare.cn/LEDE_X64_fw867/)
- physdiskwrite -u lede-v1.9-update14-r4864-32deee9-x86-64-combined-squashfs.img
- 配置电脑IP为192.168.1.2 登录到192.168.1.1 web界面 账号：admin 密码koolshare
- 统计-->备份-->生成备份

eth0 wan
eth0 wan6
eth1 lan
eth2 lan
eth3 lan
lan口网段 192.168.2.1 (直接修改配置最快)

设置wan自动获取
dbcp 192.168.200.0/24

参考资料：
- http://koolshare.cn/thread-116123-1-1.html
/etc/config/network
/etc/init.d/network reload
# 安装软件包
opkg是一个轻量快速的套件管理系统，目前已成为 Opensource 界嵌入式系统标准。常用于路由、交换机等嵌入式设备中，用来管理软件包的安装升级与下载。
常用命令
```
opkg update 更新可以获取的软件包列表
opkg upgrade 对已经安装的软件包升级
opkg list 获取软件列表
opkg install mtr 安装指定的软件包
opkg remove 卸载已经安装的指定的软件包
```
# to-do-list
- ~~Let's Encrypt配置HTTPS~~
- ~~[ddnsto内网穿透](http://koolshare.cn/thread-116500-1-1.html)~~
- ~~签到狗~~
- ~~固件更新~~
- ~~koolproxy 去广告~~
- ~~科学上网插件~~
