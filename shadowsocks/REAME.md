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

安装polipo将socks5协议转为http协议
git clone https://github.com/jech/polipo.git
cd polipo
make all
make install

# cat /etc/polipo/config
socksParentProxy = "127.0.0.1:1080"
socksProxyType = socks5
logFile = /var/log/polipo
logLevel = 99
logSyslog = true

# /root/polipo/polipo -c /etc/polipo/config
# ss -lntup|grep polipo
tcp LISTEN 0 128 127.0.0.1:8123 *:* users:(("polipo",23399,5))
export http_proxy=http://localhost:8123
curl ip.gs
```
