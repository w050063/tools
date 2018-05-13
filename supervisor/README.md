# supervisor知识总结

## supervisor概述
- 官网文档：http://supervisord.org/installing.html

## 实践
- supervisord
  ``` bash
  supervisorctl stop programxxx：停止某一个进程(programxxx)，programxxx为[program:chatdemon]里配置的值，这个示例就是chatdemon。
  supervisorctl start programxxx：启动某个进程
  supervisorctl restart programxxx：重启某个进程
  supervisorctl stop groupworker：重启所有属于名为groupworker这个分组的进程(start,restart同理)
  supervisorctl stop all：停止全部进程，注：start、restart、stop都不会载入最新的配置文件。
  supervisorctl reload：载入最新的配置文件，停止原有进程并按新的配置启动、管理所有进程。
  supervisorctl update：根据最新的配置文件，启动新配置或有改动的进程，配置没有改动的进程不会受影响而重启。
  注意：显示用stop停止掉的进程，用reload或者update都不会自动重启。
  ```
- supervisorctl
- web管理界面(inet_http_server)

### 部署安装
[install_supervisor.sh]()

## 参考资料
