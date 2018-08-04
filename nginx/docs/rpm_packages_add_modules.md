# RPM或者yum安装Nginx版本如何添加第三方模块

- 查看之前安装参数
> nginx -V

- 安装编译所需组件
> yum install -y pcre-devel openssl-devel

- 下载对应版本源码包并解压
```
git clone https://github.com/weibocom/nginx-upsync-module.git
git clone https://github.com/xiaokai-wang/nginx_upstream_check_module.git
cd nginx-1.14.0/
patch -p1 < /data0/src/nginx_upstream_check_module/check_1.12.1+.patch
```
- 使用新参数编译
```
cd nginx-1.14.0/
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie' --add-module=/data0/src/nginx_upstream_check_module --add-module=/data0/src/nginx-upsync-module
make   # 不执行 make install
```
原参数+新参数(--add-module=/data0/src/nginx_upstream_check_module --add-module=/data0/src/nginx-upsync-module)

- 升级nginx及测试
```
systemctl stop nginx
which nginx
cp /usr/sbin/nginx{,.20180804}
cp /data0/src/nginx-1.14.0/objs/nginx /usr/sbin/
systemctl start ngin
nginx -V
```
-
