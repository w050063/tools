# 概述
- 官网地址：http://www.thekelleys.org.uk/dnsmasq/doc.html
- 下载地址：http://www.thekelleys.org.uk/dnsmasq/
- GitHub地址：https://github.com/imp/dnsmasq

# 部署安装
```
ansible-playbook install_dnsmasq.yml -l 10.1.16.153
```

# 解决问题
- 莫名其妙弹出广告，消耗流量，网速编码
- 部分网站域名不能正常被解析，导致网站打不开或者时好时坏
- 管理局域网dns
- 给手机app store加速，纠正错误DNS解析记录

```
dnsmasq --no-daemon --log-queries

domain-needed                                  不转发格式错误的域名
bogus-priv                                     从不转发不在路由地址中的域名
resolv-file=/etc/dnsmasq.d/upstream_dns.conf   如果你想dns从/etc/resolv.conf之外的地方获取你的上游dns服务器
strict-order                         默认情况下dnsmasq会发送查询到它的任何上游dns服务器上，如果取消注释，则dnsmasq则会严格按照/etc/resolv.conf中的dns server顺序进行查询
```

# Docker部署


# 参考资料
- https://linux.cn/article-9438-1.html
- https://wiki.archlinux.org/index.php/Dnsmasq_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
- http://blog.51cto.com/longlei/2065967
- [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list)
