# Nginx
## Nginx概述
官网地址：https://docs.nginx.com/nginx/admin-guide/

## nginx禁止svn目录访问
``` bash
nginx
location ~ .*.(svn|git|cvs) {
    deny all;
}

apache
<Directory "/opt/www/svip/gift/webroot">
    RewriteEngine On
    RewriteRule .svn/  /404.html 
</Directory>

整理了一些方法供大家参考
禁止访问某些文件/目录
增加Files选项来控制，比如要不允许访问 .inc 扩展名的文件，保护php类库：
<Files ~ ".inc$">
   Order allow,deny
   Deny from all
</Files>

禁止访问某些指定的目录：（可以用 来进行正则匹配）
<Directory ~ "^/var/www/(.+/)*[0-9]{3}">
   Order allow,deny
   Deny from all
</Directory>

通过文件匹配来进行禁止，比如禁止所有针对图片的访问：
<FilesMatch .(?i:gif|jpe?g|png)$>
   Order allow,deny
   Deny from all
</FilesMatch>

针对URL相对路径的禁止访问：
<Location /dir/>
   Order allow,deny
   Deny from all
</Location>

针对代理方式禁止对某些目标的访问（ 可以用来正则匹配），比如拒绝通过代理访问111cn.net：
<Proxy http://www.111cn.net/*>
   Order allow,deny
   Deny from all
</Proxy>
```
## 参考资料
