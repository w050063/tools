# twemproxy知识总结

## twemproxy概述
- GitHub地址：https://github.com/twitter/twemproxy

## twemproxy安装及配置说明
### twemproxy安装
[install_twemproxy.sh](https://raw.githubusercontent.com/mds1455975151/tools/master/twemproxy/install_twemproxy.sh)

### twemproxy配置
配置案例：https://github.com/twitter/twemproxy/blob/v0.4.1/conf/nutcracker.yml

配置说明：
可以通过进程启动时使用-c or --conf-file指定YAML文件进行配置。配置文件用于指定twemproxy管理的每个池中的服务器池和服务器。

- **listen：** 监听地址和端口或该服务器池的sock文件的绝对路径(/var/run/nutcracker.sock)
- **hash：**散列函数名称
  - one_at_a_time
  - md5
  - crc16
  - crc32 (crc32 implementation compatible with libmemcached)
  - crc32a (correct crc32 implementation as per the spec)
  - fnv1_64
  - fnv1a_64
  - fnv1_32
  - fnv1a_32
  - hsieh
  - murmur
  - jenkins
- **hash_tag：**
- **timeout**
- **backlog**
- **redis**
- **redis_auth**
- **redis_db**
- **server_connections**
- **auto_eject_hosts**
- **server_retry_timeout**
- **server_failure_limit**
- **servers**

## FQA
- [2016-06-17 09:12:29.376] nc_redis.c:1092 parsed unsupported command 'keys'
> twemproxy代理redis的情况，不支持一些指令。这里错误说的是Keys指令不支持
支持Redis的命令：https://github.com/twitter/twemproxy/blob/master/notes/redis.md

- 大量TIME_WAIT
``` bash 
# netstat -tunlpa|grep 127.0.0.1:6379 |more 
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      19641/twemproxy     
tcp        0      0 127.0.0.1:56291         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:34812         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:54433         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:56282         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:32894         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:56663         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:39547         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:47716         127.0.0.1:6379          TIME_WAIT   -  
```
## 参考资料
