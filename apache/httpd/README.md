# Aapache httpd
- 配置SSL

# Apache强制HTTP全部跳转到HTTPS
## .htaccess实现
- 加载模块rewrite_module
```
LoadModule rewrite_module modules/mod_rewrite.so
```

- 网站目录的<Directory>段,打开文件允许重载
```
AllowOverride All
```

- 文件末尾追加以下内容
```
AccessFileName .htaccess
```
- 重启httpd

- 网站根目录添加.htaccess
```
```

- 编辑.htaccess设置规则
```
RewriteEngine On
RewriteCond %{SERVER_PORT} 80
RewriteRule ^(.*)$ https://%{HTTP_HOST}/$1 [R,L]
或者
RewriteEngine On
RewriteCond %{HTTPS} !=on
RewriteRule ^(.*) https://%{SERVER_NAME}/$1 [R,L]
```

相关注释

## VirtualHost添加重定向
- 区分单域名多域名
```
# cat xxx.cn.conf
<VirtualHost *:80>
   DocumentRoot /home/xxx
   ServerName xxx.cn
   ServerAlias www.xxx.cn
   ServerAdmin webmaster@virtual.host
   ErrorLog logs/xxx.cn-error_log
   CustomLog logs/xxx.cn-access_log combined
RewriteEngine on
RewriteCond %{SERVER_NAME} =xxx.cn [OR]
RewriteCond %{SERVER_NAME} =www.xxx.cn
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [L,NE,R=permanent]

</VirtualHost>
```

## 验证方法
- 通过浏览器访问
- 通过curl验证返回码
```
curl --head http://www.worldoflove.com.cn/
HTTP/1.1 301 Moved Permanently
Date: Wed, 12 Sep 2018 10:13:36 GMT
Server: Apache/2.2.15 (CentOS)
Location: https://www.worldoflove.com.cn/
Content-Type: text/html; charset=iso-8859-1
```
# FQA
- rewrite使http请求跳转到https不生效排查
```
# /etc/httpd/conf/httpd.conf
NameVirtualHost *:80
```

# 参考资料
- https://blog.csdn.net/ithomer/article/details/78986266
- http://www.cnblogs.com/kevingrace/p/9565123.html
