# Redhat
- https://access.redhat.com/documentation/zh-CN/
- Redhat使用CentOS源设置
```
1、利用原来的本地源安装lr* wget
2、删除原来的源
rpm -aq | grep yum|xargs rpm -e --nodeps
3、上传五个文件
# rpm -ivh  python-iniparse-0.3.1-2.1.el6.noarch.rpm
# rpm -ivh  yum-metadata-parser-1.1.2-16.el6.i686.rpm
# rpm -ivh  yum-3.2.29-40.el6.centos.noarch.rpm  yum-plugin-fastestmirror-1.1.30-14.el6.noarch.rpm
　　注意：最后两个安装包要放在一起同时安装，否则会提示相互依赖，安装失败。

4、清理yum缓存

# yum clean all
# yum makecache     #将服务器上的软件包信息缓存到本地,以提高搜索安装软件的速度
```
