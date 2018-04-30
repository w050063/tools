# twemproxy知识总结
## twemproxy概述
- GitHub地址：https://github.com/twitter/twemproxy

## FQA
- [2016-06-17 09:12:29.376] nc_redis.c:1092 parsed unsupported command 'keys'
> twemproxy代理redis的情况，不支持一些指令。这里错误说的是Keys指令不支持

- 大量TIME_WAIT
> # netstat -tunlpa|grep 127.0.0.1:6379 |more 
tcp        0      0 127.0.0.1:6379          0.0.0.0:*               LISTEN      19641/twemproxy     
tcp        0      0 127.0.0.1:56291         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:34812         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:54433         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:56282         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:32894         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:56663         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:39547         127.0.0.1:6379          TIME_WAIT   -                   
tcp        0      0 127.0.0.1:47716         127.0.0.1:6379          TIME_WAIT   -  
## 参考资料
