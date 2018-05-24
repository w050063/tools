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
# cat >>/etc/security/limits.conf<<EOF
* hard nofile 102400   
* soft nofile 102400
* soft nproc  20240
* hard nproc  30480
EOF
# ulimit -n
10240
# ulimit -a
-t: cpu time (seconds)              unlimited
-f: file size (blocks)              unlimited
-d: data seg size (kbytes)          unlimited
-s: stack size (kbytes)             8192
-c: core file size (blocks)         0
-m: resident set size (kbytes)      unlimited
-u: processes                       31422
-n: file descriptors                10240
-l: locked-in-memory size (kbytes)  64
-v: address space (kbytes)          unlimited
-x: file locks                      unlimited
-i: pending signals                 31422
-q: bytes in POSIX msg queues       819200
-e: max nice                        0
-r: max rt priority                 0
-N 15:                              unlimited
```
- 服务器性能排除
  
  - htop\top
  
  - nethogs\iperf
  
- 显示中文
``` bash
# export LANG='zh_CN.UTF-8'
```
- shell退出
  - exit 退出脚本
  
  - return 退出函数
  
  - break 中断整个循环
  
  - continue 退出本次循环
  
## Ubuntu

## Other
