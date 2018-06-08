# GrayLog知识总结
## GrayLog概述
## GrayLog安装部署
## GrayLog日常管理
### [使用agent收集log](http://docs.graylog.org/en/latest/pages/collector_sidecar.html#backends)
[agent下载](https://github.com/Graylog2/collector-sidecar/releases)

``` bash
Beats backend

# wget https://github.com/Graylog2/collector-sidecar/releases/download/0.1.4/collector-sidecar-0.1.4-1.x86_64.rpm
# rpm -ivh collector-sidecar-0.1.4-1.x86_64.rpm
# rpm -ql collector-sidecar-0.1.4-1
/etc/graylog/collector-sidecar/collector_sidecar.yml        # 主配置文件
/etc/graylog/collector-sidecar/generated                    # 子配置文件路径/etc/graylog/collector-sidecar/generated/filebeat.yml
/usr/bin/filebeat                                           # 二进制
/usr/bin/graylog-collector-sidecar                          # 二进制执行文件
/var/log/graylog/collector-sidecar                          # 日志路径
/var/run/graylog/collector-sidecar                          # 空目录
/var/spool/collector-sidecar/nxlog                          # 空目录      
# graylog-collector-sidecar -service install               
# systemctl start collector-sidecar
# systemctl enable collector-sidecar   
# curl -u madongsheng:xxx --head 127.0.0.1:9000/api/system/
HTTP/1.1 200 OK
X-Graylog-Node-ID: c2442555-b465-4c88-95e7-2a0d68a1305c
X-Runtime-Microseconds: 271411
Content-Length: 391
Content-Type: application/json
Date: Wed, 09 May 2018 09:13:11 GMT

# logger -t graylog-ubuntu -n 10.1.16.124 -P 12201 "11111"   # Syslog UDP 测试方式

# Application GELF UDP 测试方式
# echo -n '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' | nc -w 5 -u 10.1.16.124 12201
参考资料：http://docs.graylog.org/en/2.4/pages/gelf.html

```
## 参考资料
