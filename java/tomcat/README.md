# 概述
- 官网地址：https://tomcat.apache.org/
- 官网文档：
# to-do-list
- 快速部署
- 设置SSL



# https

```
# 获取Let's Encrypt免费SSL证书
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt
./letsencrypt-auto --help

# 获取证书
./letsencrypt-auto certonly --standalone --email 1455975151@qq.com -d sso.dev.xxx.cn
cd /etc/letsencrypt/live/sso.dev.xxx.cn
ls -al
total 4
-rw-r--r-- 1 root root 682 Sep 22 15:53 README
lrwxrwxrwx 1 root root  46 Sep 22 15:53 cert.pem -> ../../archive/sso.dev.xxx.cn/cert1.pem
lrwxrwxrwx 1 root root  47 Sep 22 15:53 chain.pem -> ../../archive/sso.dev.xxx.cn/chain1.pem
lrwxrwxrwx 1 root root  51 Sep 22 15:53 fullchain.pem -> ../../archive/sso.dev.xxx.cn/fullchain1.pem
lrwxrwxrwx 1 root root  49 Sep 22 15:53 privkey.pem -> ../../archive/sso.dev.xxx.cn/privkey1.pem

# 转换证书格式需要用到的是后面两个证书文件:fullchain.pem和privkey.pem
# 导出.p12格式的证书
$ openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out letsencrypt.p12 -name tomcat_letsencrypt

# 再将证书由.p12格式转换成.jks格式
$ keytool -importkeystore -deststorepass '123456' -destkeypass '123456' -destkeystore letsencrypt.jks -srckeystore letsencrypt.p12 -srcstoretype PKCS12 -srcstorepass '123456' -alias tomcat_letsencrypt

vim /usr/local/tomcat/conf/server.xml
<Connector
       protocol="org.apache.coyote.http11.Http11NioProtocol"
       port="8443" maxThreads="200"
       scheme="https" secure="true" SSLEnabled="true"
       keystoreFile="conf/letsencrypt.jks" keystorePass="123456"
       clientAuth="false" sslProtocol="TLS"/>
```

# 参考资料
- https://blog.csdn.net/lyq8479/article/details/79022888
