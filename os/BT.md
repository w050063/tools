# 概述
官网地址：https://www.backtrack-linux.org/
https://www.kali.org/

## 基本信息
```
lsb_release -a
```

## 网络设置
```
vim /etc/network/interfaces
/etc/init.d/networking restort

source /etc/network/interfaces.d/*

#auto eth1
#iface eth1 inet static
#address 192.168.200.200
#gateway 192.168.200.1
#netmask 255.255.255.0
```
## ssh设置
```
vi /etc/ssh/sshd_config     # 修改config文件内容
    PermitRootLogin yes     # 修改内容
    PasswordAuthentication yes    #修改内容
/etc/init.d/ssh start
update-rc.d ssh enable      # 添加ssh开启自动启动
```

## 设置软件源
```
vim /etc/apt/sources.list
#中科大
deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib

#官方源
#deb http://http.kali.org/kali kali-rolling main non-free contrib
#deb-src http://http.kali.org/kali kali-rolling main non-free contrib

apt-get clean && apt-get update
```

## 切换中文显示
```
dpkg-reconfigure locales
选择字符编码：en_US.UTF-8、zh_CN.GBK、zh_CN.UTF-8
选择字符：zh_CN.UTF-8（记得用空格）
设置完后reboot

切换中文后乱码 字体不支持中文（apt-get upgrade之后的后遗症）
LANG=en_US.UTF-8
apt-get install ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy
apt-get install -y gnome-tweak-tool
gnome-tweak-tool

选中font，然后将所有的font都改成我们刚刚下载的文泉驿的字体，一般是在最后，有wenquanyi-xxxxx的这种，然后就可以恢复正常了。
```
## 安装输入法
```
apt-get install -y fcitx
apt-get install -y fcitx-googlepinyin
reboot

```
## vpc远程桌面连接
```
设置用软件源后 最好在英文环境下，中文下会连接异常

apt-get install xrdp
apt-get install xfce4
apt-get install vnc4server tightvncserver
vi /etc/xrdp/startwm.sh
echo "xfce4-session" >~/.xsession    # 在./etc/X11/Xsession前插入xfce4-session
/etc/init.d/xrdp restart
```

# 基本软件安装
```
apt-get install gnome-tweak-tool        #安装gnome管理软件

apt-get install software-center         #安装ubuntu软件中心
apt-get install file-roller           #安装解压缩软件
apt-get install clementine           #clementine音乐播放器     
apt-get install smplayer            #安装smplayer视频播放器    
apt-get install terminator         #安装多窗口终端 ps:安装后Open In Terminal 不能使用
                        
apt-get install htop rar aria2         #安装秒杀top的htop,原版rar下载工aria2  
apt-get install gdebi             #安装Deb包图形安装工具       
apt-get install gnome-tweak-tool       #安装Gnome3优化设置工具    
apt-get install nautilus-open-terminal      #安装右键打开"Open In Terminal”的快捷方式
apt-get install netspeed              #安装显示当前网络上传下载速度的GNOME applet
sudo apt-get install yum               #安装yum 命令            
sudo yum install gcc                 #安装gcc 命令
sudo apt-get install net-tools 
```
