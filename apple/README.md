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

7、其他
NAS路径：/volume1/Teamcity
挂载路径：/Library/TeamCity/nas_teamcity/Teamcity

相关参考资料：
- https://support.apple.com/zh-cn/HT202181
```
- 机器监控

# Mac OS
- [Homebrew](https://brew.sh/)
- [技术文档](https://kapeli.com/dash)
