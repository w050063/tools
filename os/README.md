# 操作系统相关问题
## CentOS
- 关闭ipv6协议
- 禁ping和开启ping操作
  ``` bash 
  echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all  # 禁止ping
  echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all  # 开启ping
  ```
- 挂载iso文件
  ``` bash
  mount -o loop -t iso9660 /media/Linux/CentOS-6.5-i386-bin-DVD1.iso /mnt
  ```
- 文件描述符
``` bash
cat >>/etc/security/limits.conf<<EOF
* hard nofile 102400   
* soft nofile 102400
* soft nproc  20240
* hard nproc  30480
EOF
```
- 服务器性能排除
  
  - htop\top
  
  - nethogs\iperf
  
## Ubuntu

## Other
