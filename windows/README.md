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
## windows 10
- Windows10安装时停留在准备就绪上
  1、关闭电脑重新启动电脑并在开机前使用快捷键进入BIOS。（win10系统怎么进入bios win10无法进入bios的解决方法）
  2、在BIOS设置里找到有关CPU设置的选项Advanced。
  在此选项下有一项包涵IDE字样的设置选项叫IDE Configuration或类似的选项。
  进入它的子选项找到SATA Mode，在此设置上敲一下回车会弹出一个新的复选项，将其改为IDE Mode模式。
  3、修改完后将BIOS设置进行保存。
  4、重新启动电脑或进入PE系统进行重新安装。
## 参考资料
