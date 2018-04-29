# supervisor知识总结
## supervisor概述
- 官网文档：http://supervisord.org/installing.html
## 实践
### 部署安装
``` bash
yum install -y python-pip
pip install supervisor
echo_supervisord_conf >/etc/supervisord.conf
mkdir -p /etc/supervisord/conf.d/
```
## 参考资料
