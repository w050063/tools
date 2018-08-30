- [nginx_upstream_check_module](https://github.com/xiaokai-wang/nginx_upstream_check_module)：nginx主动健康检查模块
- [nginx-upsync-module](https://github.com/weibocom/nginx-upsync-module)：nginx服务发现模块
- [ngx_http_google_filter_module](https://github.com/cuber/ngx_http_google_filter_module)
- []
```
wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar -zxf LuaJIT-2.0.5.tar.gz
cd LuaJIT-2.0.5
make
make install PREFIX=/usr/local/luajit-2.0.5
cd /data0/src/
git clone https://github.com/openresty/lua-nginx-module.git
git clone https://github.com/simplresty/ngx_devel_kit.git

export LUAJIT_LIB=/usr/local/luajit-2.0.5/lib/
export LUAJIT_INC=/usr/local/luajit-2.0.5/include/luajit-2.0
--with-ld-opt="-Wl,-rpath,/usr/local/luajit-2.0.5/lib" --add-module=/data0/src/ngx_devel_kit --add-module=/data0/src/lua-nginx-module
```
