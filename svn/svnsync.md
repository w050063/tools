svnsync要求svn版本1.4+
svnsync是Subversion的远程版本库镜像工具，它允许你把一个版本库的内容录入到另一个。

在任何镜像场景中，有两个版本库：源版本库，镜像(或“sink”)版本库，源版本库就是svnsync获取修订版本的库，镜像版本库是源版本库修订版本的目标，两个版本库可以是在本地或远程—它们只是通过URL跟踪。

svnsync进程只需要对源版本库有读权限；它不会尝试修改它。但是很明显，svnsync可以读写访问镜像版本库。

```
mkdir -p /data0/svn
cd /data0/svn
svnadmin create svn-mirror
svnserve -r /data0/svn/ -d

两侧配置用户
svnsync initialize svn://10.135.95.147/svn-mirror \
                     svn://jenkins.dev.xxx.cn/loveworld \
                     --username madongsheng --password madongsheng

简写
svnsync init svn://10.135.95.147/svn-mirror \
                    svn://jenkins.dev.xxx.cn/loveworld \
                    --username madongsheng --password madongsheng

svnsync: E165006: Repository has not been enabled to accept revision propchanges;
ask the administrator to create a pre-revprop-change hook

svn://10.135.95.147/svn-mirror
# cat svn-mirror/hooks/pre-revprop-change
#!/bin/sh

USER="$3"

if [ "$USER" = "madongsheng" ]; then exit 0; fi

echo "Changing revision properties other than svn:log is prohibited" >&2
exit 1


svnsync synchronize svn://10.135.95.147/svn-mirror \
                      --username madongsheng --password madongsheng

svnsync synchronize --non-interactive svn://10.135.95.147/svn-mirror \
                      --username madongsheng --password madongsheng


svnsync synchronize http://192.168.3.10/svn-mirror \
                      --username syncuser --password syncpass
```		  

https://www.cnblogs.com/zz0412/p/svnsync.html
https://www.cnblogs.com/xiaxiaosheng/p/6021616.html
