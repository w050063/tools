# supervisor知识总结
## supervisor概述
- 官网文档：http://supervisord.org/installing.html
## 实践
### 部署安装
``` bash
yum install -y python-pip
pip install supervisor
mkdir -p /etc/supervisord/conf.d/
echo_supervisord_conf >/etc/supervisor/supervisord.conf
mkdir -p /etc/supervisord/conf.d/
sed -i 's#;[include]#[include]#g' /etc/supervisor/supervisord.conf
sed -i 's#;files = relative/directory/*.ini#files = /etc/supervisord/conf.d/*.ini#g' /etc/supervisor/supervisord.conf
supervisord -c /etc/supervisor/supervisord.conf
```
## 参考资料
