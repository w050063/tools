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
```
## 参考资料
