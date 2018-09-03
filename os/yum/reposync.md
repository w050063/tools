> 利用reposync快速部署私有仓库

## 配置官网repo文件
```
cd /etc/yum.repos.d/
wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.0.0/ambari.repo
wget http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.0.0.0/hdp.repo
yum makecache
```
## 查看repo列表
```
# yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.aliyun.com
 * extras: mirrors.aliyun.com
 * updates: mirrors.aliyun.com
repo id                                                  repo name                                                                       status
local                                                    LocalRepo                                                                          175
base/7/x86_64                                            CentOS-7 - Base - mirrors.aliyun.com                                             9,911
extras/7/x86_64                                          CentOS-7 - Extras - mirrors.aliyun.com                                             402
updates/7/x86_64                                         CentOS-7 - Updates - mirrors.aliyun.com                                          1,333
repolist: 24,621
```
## 同步仓库文件
```
# reposync -r local       # 根据repo id同步仓库文件
(1/174): OpenEXR-libs-1.7.1-7.el7.x86_64.rpm                                                                            | 217 kB  00:00:00     
(2/174): aspell-0.60.6.1-9.el7.x86_64.rpm                                                                               | 686 kB  00:00:01     
(3/174): audit-2.7.6-3.el7.x86_64.rpm                                                                                   | 242 kB  00:00:00     
(4/174): audit-libs-2.7.6-3.el7.x86_64.rpm                                                                              |  96 kB  00:00:00     
(5/174): audit-libs-python-2.7.6-3.el7.x86_64.rpm                                                                       |  73 kB  00:00:00     
(6/174): autoconf-2.69-11.el7.noarch.rpm                                                                                | 701 kB  00:00:00     
.......
```
## 创建源信息
## 测试验证
