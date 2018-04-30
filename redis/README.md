# Redis知识总结
## Redis概述
## Redis多实例
``` bash
cp /etc/redis-6380.conf /etc/redis-6381.conf
sed -i 's/6380/6381/g' /etc/redis-6381.conf
mkdir -p /var/lib/redis-6381
redis-server /etc/redis-6381.conf
netstat -tunlp
cat>>/etc/rc.local<<EOF
redis-server /etc/redis-6381.conf
EOF
```
## Redis性能压测
## twemproxy
- 编译
- 安装
- 配置
- 性能测试
## 参考资料
