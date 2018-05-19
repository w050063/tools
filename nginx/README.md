# Nginx
## Nginx概述
官网地址：https://docs.nginx.com/nginx/admin-guide/

## 性能优化
### 内核参数
``` bash

```
### 配置参数
``` bash
[root@dev-huanqiu ~]# cat /usr/local/nginx/conf/nginx.conf
user   www www;
worker_processes 8;
worker_cpu_affinity 00000001 00000010 00000100 00001000 00010000 00100000 01000000;
error_log   /www/log/nginx_error.log   crit;
pid         /usr/local/nginx/nginx.pid;
worker_rlimit_nofile 65535;
 
events
{
   use epoll;
   worker_connections 65535;
}
 
http
{
   include       mime.types;
   default_type   application/octet-stream;
 
   charset   utf-8;
 
   server_names_hash_bucket_size 128;
   client_header_buffer_size 2k;
   large_client_header_buffers 4 4k;
   client_max_body_size 8m;
 
   sendfile on;
   tcp_nopush     on;
 
   keepalive_timeout 60;
 
   fastcgi_cache_path /usr/local/nginx/fastcgi_cache levels=1:2
                 keys_zone=TEST:10m
                 inactive=5m;
   fastcgi_connect_timeout 300;
   fastcgi_send_timeout 300;
   fastcgi_read_timeout 300;
   fastcgi_buffer_size 16k;
   fastcgi_buffers 16 16k;
   fastcgi_busy_buffers_size 16k;
   fastcgi_temp_file_write_size 16k;
   fastcgi_cache TEST;
   fastcgi_cache_valid 200 302 1h;
   fastcgi_cache_valid 301 1d;
   fastcgi_cache_valid any 1m;
   fastcgi_cache_min_uses 1;
   fastcgi_cache_use_stale error timeout invalid_header http_500; 
   open_file_cache max=204800 inactive=20s;
   open_file_cache_min_uses 1;
   open_file_cache_valid 30s; 
 
   tcp_nodelay on;
   
   gzip on;
   gzip_min_length   1k;
   gzip_buffers     4 16k;
   gzip_http_version 1.0;
   gzip_comp_level 2;
   gzip_types       text/plain application/x-javascript text/css application/xml;
   gzip_vary on;
 
   server
   {
     listen       8080;
     server_name   huan.wangshibo.com;
     index index.php index.htm;
     root   /www/html/;
 
     location /status
     {
         stub_status on;
     }
 
     location ~ .*\.(php|php5)?$
     {
         fastcgi_pass 127.0.0.1:9000;
         fastcgi_index index.php;
         include fcgi.conf;
     }
 
     location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|js|css)$
     {
       expires       30d;
     }
 
     log_format   access   '$remote_addr - $remote_user [$time_local] "$request" '
               '$status $body_bytes_sent "$http_referer" '
               '"$http_user_agent" $http_x_forwarded_for';
     access_log   /www/log/access.log   access;
       }
}
```
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
