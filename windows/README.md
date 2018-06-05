# windows相关技能
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
## powershell
## windows下常用工具
## 常见接口类型
### 接口类型
- VGA
针数为15的视频接口，主要用于老式的电脑输出。VGA输出和传递的是模拟信号。大家都知道计算机显卡产生的是数字信号，显示器使用的也是数字信号。所以使用VGA的视频接口相当于是经历了一个数模转换和一次模数转换。信号损失，显示较为模糊。
![image](https://github.com/mds1455975151/tools/blob/master/vitess/docs/images/VitessOverview.png)
- DVI
DVI高清接口，不带音频，只能传输画面图形信号，但不传输音频信号。DVI接口有两个标准，25针和29针。DVI接口传输的是数字信号，可以传输大分辨率的视频信号。DVI连接计算机显卡和显示器时不用发生转换，所以信号没有损失。如下图：
![image](https://github.com/mds1455975151/tools/blob/master/vitess/docs/images/VitessOverview.png)

- HDMI
数字信号，所以在视频质量上和DVI接口传输所实现的效果基本相同。HDMI接口还能够传送音频信号。假如显示器除了有显示功能，还带有音响时，HDMI的接口可以同时将电脑视频和音频的信号传递给显示器。HDMI有三个接口。主要考虑到设备的需要。如数码相机的体积小，需要小的接口，就使用micro HDMI。三种接口只是在体积上有区别，功能相同。如图所示：
![image](https://github.com/mds1455975151/tools/blob/master/vitess/docs/images/VitessOverview.png)

- DP
DisplayPort也是一种高清数字显示接口标准，可以连接电脑和显示器，也可以连接电脑和家庭影院。DisplayPort赢得了AMD、Intel、NVIDIA、戴尔、惠普、联想、飞利浦、三星、aoc等业界巨头的支持，而且它是免费使用的。
DP接口可以理解是HDMI的加强版，在音频和视频传输方面更加强悍。

VGA、DVI、HDMI相互转换的说明
VGA和DVI互转：模拟信号和数字信号的转换，视频信号损失，造成失真。最好不要这样转换。
DVI和HDMI互转：都是数字信号，转换不会发生是真。可以转换。但是从HDMI转换成DVI时会自动舍去音频信号

视频接口的发展经历是：VGA->DVI->HDMI。
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
## 参考资料
