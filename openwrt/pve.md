# 概述

# 部署
- 下载Proxmox Virtual Environment 5.2 (ISO Image)
- 参考usb安装Instructions for Windows
https://pve.proxmox.com/wiki/Install_from_USB_Stick
- 插入U盘安装系统
  - 设置地区、语言
  - 设置主机名
  - 设置密码
  - 设置IP
- 插入网线，配置IP，确认web及ssh连通性
  - web地址：https://192.168.100.2:8006/
  - 登录设置语言

- 上传镜像
选择local(pve)--内容--上传--ios

# to-do-list
- ~~PVE系统安装~~
- 配置PVE连接外网
- [PVE面板增加CPU温度展示](http://www.ezpro.pro/thread-188-1-1.html)

# 参考资料
- https://pve.proxmox.com
- [做一个适合自己的路由(爱快+LEDE)](https://www.chiphell.com/thread-1843671-1-1.html)
- [Proxmox VE导入OpenWrt/LEDE固件的工具——img2kvm](img2kvm)
- http://everun.top
```
service --status-all
apt
```
```
房东路由器
PVE虚拟机 192.168.100.2
openwrt路由器: 192.168.2.1 网段192.168.2.2-254


systemctl restart pveproxy      # 重启PVE的Web管理服务
```


# Debian系统知识
```
cat /etc/debian_version
添加aliyun源
apt-get update
```
