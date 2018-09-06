# 免费SSL证书
https://certbot.eff.org

# 免费SSL证书优缺点
- 优点
  - 免费

- 缺点
  - 大规模使用复杂 过期管理

# 证书过期时间检查及报警
- https://github.com/matteocorti/check_ssl_cert (推荐)
- https://github.com/Matty9191/ssl-cert-check
- https://github.com/srvrco/checkssl
- https://github.com/selivan/https-ssl-cert-check-zabbix
- https://github.com/adfinis-sygroup/check-ssl

```
./check_ssl_cert -H xxx.gs.xxx.cn|awk -F '[=;]+' '{print $2}'  # 计算还有多少天证书过期
```
# 相关实践
## 用OpenSSL生成自签名证书
```
# 生成 CA 证书的 key
openssl genrsa -out ca.key 4096

# 根据 key 生成 CA 证书
openssl req -new -x509 -days 365 -key ca.key -out ca.crt

# 服务器 key
openssl genrsa -out server.key 4096

# 服务器证书请求
openssl req -new -key server.key -out server.csr

# 用 ca 签名服务器证书请求，生成一个有效期为 365 天的证书
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
```

## 用CFSSL生成自签名证书
## mkcert
# 工具
- https://github.com/Neilpang/acme.sh
- https://github.com/geerlingguy/ansible-role-certbot
- [stunnel](http://www.stunnel.org/): Stunnel是一种代理，旨在为现有客户端和服务器添加TLS加密功能，而无需对程序代码进行任何更改。其架构针对安全性，可移植性和可扩展性（包括负载平衡）进行了优化，使其适用于大型部署。
