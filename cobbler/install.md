# Cobbler无人值守自动化安装

## 一.安装步骤
<pre>
1. yum install -y httpd dhcp tftp cobbler cobbler-web pykickstart ##安装所需要的服务。

2. systemctl start httpd.service     ##启动http。

3. systemctl start cobblerd.service  ##启动cobbler。

4. cobbler check ##检查是否有报错。

5. iptables -vnL 
   iptables -F
   iptables -t nat -F
   systemctl stop firewalld  ##检查防火墙。

6. vim /etc/cobbler/settings
   272 next_server: 10.0.0.7
   384 server: 10.0.0.7

7. vim /etc/xinetd.d/tftp
   disable                 = no

8. cobbler get-loaders

9. systemctl start rsyncd.service

10. openssl passwd -1 -salt 'cobler' 'cobler'  
    $1$cobler$XJnisBweZJlhL651HxAM00

11. vim /etc/cobbler/settings
    101 default_password_crypted: "$1$cobler$XJnisBweZJlhL651HxAM00"

12. systemctl restart cobblerd.service
    cobbler check

13. vim /etc/cobbler/settings
    242 manage_dhcp: 1

14. vim /etc/cobbler/dhcp.template

15. systemctl restart cobblerd.service
    cobbler sync

16. mount /dev/cdrom /mnt

17. cobbler import  --path=/mnt/ --name=CentOS-7-x86_64 --arch=x86_64

18. cobbler profile edit --name=CentOS-7-x86_64 --kickstart=/var/lib/cobbler/kickstarts/CentOS-7-x86_64.cfg

    cobbler profile edit --name=CentOS-7-x86_64 --kopts='net.ifnames=0 biosdevname=0'

19. cobbler sync

20. yum install -y xinetd.x86_64 -y
    systemctl start xinetd.service
 
</pre>


### 注意：**centos7装机出现的错误：将虚拟机的内存提高到2g！！**

## 二.CentOS7-7_x86__64.cfg
<pre>
lang en_US
keyboard us
timezone Asia/Shanghai
rootpw  --iscrypted $default_password_crypted
text
install
url --url=$tree
bootloader --location=mbr
zerombr
clearpart --all --initlabel
part /boot --fstype xfs --size 1024 --ondisk sda
part swap --size 16834 --ondisk sda
part / --fstype xfs --size 1 --grow --ondisk sda
auth --useshadow --enablemd5
$SNIPPET('network_config')
reboot
firewall --disabled
selinux --disabled
skipx
%pre
$SNIPPET('log_ks_pre')
$SNIPPET('kickstart_start')
$SNIPPET('pre_install_network_config')
$SNIPPET('pre_anamon')
%end

%packages
@base
@core
sysstat
iptraf
ntp
lrzsz
ncurses-devel
openssl-devel
zlib-devel
OpenIPMI-tools
mysql
nmap
screen
%end

%post
systemctl disable postfix.service、

$yum_config_stanza
%end
</pre>

## 三.cobbler自动重装和cobbler-web
<pre>
yum install koan

koan --server=10.0.0.7 --list=profiles

koan --replace-self --server=10.0.0.7 --profile=CentOS-7-x86_64 #指定要重装的系统
</pre>

### cobbler-web如何修改密码
		
	htdigest /etc/cobbler/users.digest "Cobbler" cobbler

### cobbler同步源
		
<pre>
1、cobbler repo add --name=openstake-queens --mirror=https://mirrors.aliyun.com/centos/7.4.1708/cloud/x86_64/openstack-queens/ --arch=x86_64 --breed=yum
2、cobbler reposync自动下载repo文件
3、cobbler profile edit --name=CentOS-7-x86_64 --repos=https://mirrors.aliyun.com/centos/7.4.1708/cloud/x86_64/openstack-queens/
4、修改kickstart文件   
  %post
  systemctl disable postfix.service

  $yum_config_stanza
  %end                           
</pre>

### 添加定时任务，定期同步到repo
	echo “1 3 * * * /usr/bin/cobbler reposync --tries=3 --no-fail” >> /var/spool/cron/root		


