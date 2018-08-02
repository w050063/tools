- 新建账号
- 磁盘管理
```
df -H
```
- Mac OSX挂载NAS记录
```
1、查看现有挂载
mount -v

2、查看现有自动挂载设置
automount -v

3、配置自动挂载(https://gist.github.com/rudelm/7bcc905ab748ab9879ea)
# cat /etc/auto_nas_teamcity
Teamcity -fstype=afp,rw afp://build:xxx@nas.dev.xxx.cn:/Teamcity

4、卸载NFS
# umount /Library/TeamCity/nas_teamcity/
umount(/Library/TeamCity/nas_teamcity): Resource busy -- try 'diskutil unmount'
# diskutil unmount /Library/TeamCity/nas_teamcity/
Unmount failed for /Library/TeamCity/nas_teamcity/      # 待解决

5、自动挂载相关配置
/etc/autofs.conf

6、手动挂载操作
- mount share
  mkdir -p /tmp/afptest
  mount_afp afp://build:xxx@nas.dev.xxx.cn:/Teamcity /tmp/afptest (格式： mount_afp 'afp://<username>:<passwd>@ip/src_dir' dest_dir)
- umount share
  umount /tmp/afptest

7、新增挂载点
- 新增配置
# vim /etc/auto_nas_test
test -fstype=afp,rw afp://build:xxx@nas.dev.xxx.cn:/test
- 将新配置/etc/auto_nas_test加入/etc/auto_master配置
# vim /etc/auto_master
/tmp/nas_test auto_nas_test
- 执行挂载
automount -vc

8、其他
NAS路径：/volume1/Teamcity
挂载路径：/Library/TeamCity/nas_teamcity/Teamcity
重启autofs服务：
  - sudo service com.apple.autofsd stop
	- sudo service com.apple.autofsd start
	- sudo launchctl stop com.apple.autofsd
  
9、FQA
  - autofs无法正常工作(Mac OS 10.12.1+) 
	  - https://discussions.apple.com/thread/7677185?answerId=30688767022#30688767022
	  - https://forum.synology.com/enu/viewtopic.php?f=64&t=122975

相关参考资料：
- https://support.apple.com/zh-cn/HT202181
```
- 机器监控
# 自动化管理
- https://github.com/geerlingguy/ansible-role-homebrew
- https://github.com/homebrew
- https://github.com/daemonza/setupmac
- https://github.com/bennylope/macbook-configuration

# Mac OS
- [Homebrew](https://brew.sh/)
- [技术文档](https://kapeli.com/dash)
