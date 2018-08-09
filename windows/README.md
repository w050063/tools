# windows相关技能
- Termius(ssh工具)
## 系统及软件下载
- https://msdn.itellyou.cn/
## bat
- 利用bat增删改查注册表信息
  ``` bat
  # cat nas.reg         # 修改指定注册表键值信息
  Windows Registry Editor Version 5.00

  [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters]
  "EnablePlainTextPassword"=dword:00000001
  ```
- 获取系统MAC地址做mac地址绑定或者限速等等
  ``` bat
  # cat getinfo.bat
  ipconfig /all  >> getinfo.txt

  # cat getinfo.sh  # macos or linux
  ifconfig >> getinfo.txt
  ```
- 路由追踪
  ``` bat
  # tracert www.baidu.com
  ```
## PowerShell
- 概述
> Windows PowerShell 是专为系统管理员设计的新 Windows 命令行外壳程序。该外壳程序包括交互式提示和脚本环境，两者既可以独立使用也可以组合使用。 
与接受和返回文本的大多数外壳程序不同，Windows PowerShell 是在 。NET 公共语言运行时 (CLR) 和 。NET Framework 的基础上构建的，它接受和返回 。NET 对象。环境中的这一根本更改带来了管理和配置 Windows 的全新工具和方法。

- 查看PowerShell版本
> $PSVersionTable
- 查看安装的.Net framework版本信息
> $PSVersionTable.CLRVersion

## windows下常用工具
- window下包管理工具
> https://chocolatey.org/

## Ansible and saltstack管理Window机器
- https://docs.ansible.com/ansible/latest/user_guide/windows.html

## 常见接口类型
### 视频接口类型
- VGA

针数为15的视频接口，主要用于老式的电脑输出。VGA输出和传递的是模拟信号。计算机显卡产生的是数字信号，显示器使用的也是数字信号。所以使用VGA的视频接口相当于是经历了一个数模转换和一次模数转换。信号损失，显示较为模糊。

![image](https://github.com/mds1455975151/tools/blob/master/windows/images/01.png)
- DVI

DVI高清接口，不带音频，只能传输画面图形信号，但不传输音频信号。DVI接口有两个标准，25针和29针。DVI接口传输的是数字信号，可以传输大分辨率的视频信号。DVI连接计算机显卡和显示器时不用发生转换，所以信号没有损失。如下图：
![image](https://github.com/mds1455975151/tools/blob/master/windows/images/02.png)

- HDMI

数字信号，所以在视频质量上和DVI接口传输所实现的效果基本相同。HDMI接口还能够传送音频信号。假如显示器除了有显示功能，还带有音响时，HDMI的接口可以同时将电脑视频和音频的信号传递给显示器。HDMI有三个接口。主要考虑到设备的需要。如数码相机的体积小，需要小的接口，就使用micro HDMI。三种接口只是在体积上有区别，功能相同。如图所示：

![image](https://github.com/mds1455975151/tools/blob/master/windows/images/03.png)

- DP

DisplayPort也是一种高清数字显示接口标准，可以连接电脑和显示器，也可以连接电脑和家庭影院。DisplayPort赢得了AMD、Intel、NVIDIA、戴尔、惠普、联想、飞利浦、三星、aoc等业界巨头的支持，而且它是免费使用的。
DP接口可以理解是HDMI的加强版，在音频和视频传输方面更加强悍。

- VGA、DVI、HDMI相互转换的说明

VGA和DVI互转：模拟信号和数字信号的转换，视频信号损失，造成失真。最好不要这样转换。
DVI和HDMI互转：都是数字信号，转换不会发生是真。可以转换。但是从HDMI转换成DVI时会自动舍去音频信号

- 视频接口的发展经历是：VGA->DVI->HDMI。
### USB接口类型
USB Type-C接口是USB接口的一种类型。USB接口目前主要有四个接口类型：

- 1、USB Type-A，这种接口类型是最常见的USB接口，主要用在电脑，充电器，鼠标，键盘，U盘等设备上。
- 2、USB Type-B，这种接口类型主要用在打印机等设备上，没有type-A接口常见。
- 3、Micro-B，这种接口都见过，就是手机充电器的接口。
- 4、USB Type-C，这一种就是以后USB接口的发展趋势。

![image](https://github.com/mds1455975151/tools/blob/master/windows/images/05.png)

USB Type-C最明显的特点就是支持正反面盲插
- 1、支持大电流和大电压充电，有助于提高充电速度，可以说Type-C接口就是为快充技术而生的，以后针对USB Type-C接口的快充技术肯定越来越多。
- 2、支持双向供电，使用USB Typc-C接口既可给设备自身充电，也可给外接设备供电。（这样我们就可以实现串联充电，用一根USB Typc-C接口的线串联不同的设备即可）。
- 3、扩展能力强，USB Type-C可以传输影音信号，那么其就可以扩展为多种音视频输出接口，如HDMI、DVI、VGA接口（简单的说，就是其可以作为HDMI、DVI、VGA接口使用，所以，只要有一根USB Type-C接口线，就不用在买一些HDMI、DVI、VGA接口线）了。

![image](https://github.com/mds1455975151/tools/blob/master/windows/images/04.png)     
## windows 10
- Windows10安装时停留在准备就绪上
  ``` text
  1、关闭电脑重新启动电脑并在开机前使用快捷键进入BIOS。（win10系统怎么进入bios win10无法进入bios的解决方法）
  2、在BIOS设置里找到有关CPU设置的选项Advanced。
  在此选项下有一项包涵IDE字样的设置选项叫IDE Configuration或类似的选项。
  进入它的子选项找到SATA Mode，在此设置上敲一下回车会弹出一个新的复选项，将其改为IDE Mode模式。
  3、修改完后将BIOS设置进行保存。
  4、重新启动电脑或进入PE系统进行重新安装。
  ```
## 主机两个按钮
主机箱上只有两个按钮，一个是开关按钮，另一个称作复位按钮。

- 开关按钮，就是用来开启机箱运行，或者按住此钮不放也能够关闭，通常来说，主机箱上电源开关按钮在外观上都比较大型，比较醒目，以方便按下开机。
- 复位按钮，就是用来进行复位或者强制重启，因为计算机也偶尔出现系统卡死或者各种故障，如果电脑已经卡死到没有任何动作了，就可以按这个复位钮强制性重启。但是正常情况下不要按复位，否则会造成硬件损坏。在机箱外观上复位按钮通常比较细小，或者比较隐蔽，严禁在正常运行的状态按复位。

正常运行的计算机如果按一次开关按钮，系统通常不会有反映，关闭计算机首先要在开始菜单去点击关机，运行中严禁直接按电源开关或者严禁直接拔掉插头等方式断电，否则会造成计算机系统损坏或者文件损坏。windows7系统控制面板可以设置电源开关的作用。

## FQA
