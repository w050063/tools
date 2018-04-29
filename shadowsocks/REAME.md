# shadowsocks总结
## Linux系统
``` bash
yum install python-setuptools && easy_install pip
pip install shadowsocks
cat>/etc/shadowsocks.json<<EOF
{
    "server":"服务器的ip",
    "server_port":19175,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"密码",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false
}
EOF
sslocal -c /etc/shadowsocks.json
```
