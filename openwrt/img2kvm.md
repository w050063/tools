img2kvm是一个在PVE下导入OW固件到虚拟机的工具，可以将固件文件（含gz的压缩格式）一次性导入到OW虚拟机中，从而简化让人工操作的麻烦。

使用img2kvm -h可以直接获取帮助信息，主要内容如下：

A utility that convert OpenWrt firmware to disk image for KVM guest in Proxmox VE.
Copyright (C) 2017-2018 everun.top
usage: img2kvm <img_name> <vm_id> <vmdisk_name> [storage]

 -h or --help display this help.
 -V or --version output img2kvm version informaton.

Command parameters:
 img_name the name of OpenWrt image file, e.g. 'openwrt-x86-kvm64-combined-ext4.img'.
 vm_id the ID of VM for OpenWrt guest, e.g. '200'.
 vmdisk_name the name of disk for OpenWrt guest, e.g. 'vm-200-disk-1'.
 storage Storage pool of Proxmox VE, default is 'local-lvm'.
其中，-h可以获得所有的帮助信息，-V可以获得版本信息。

目前，最新的img2kvm版本为v0.1.5。

所用的命令格式为：

img2kvm <img_name> <vm_id> <vmdisk_name> [storage]
其具体参数说明如下：

img_name：是OW固件的文件名称。一般为“xxx.img”或“xxx.img.gz”的格式。img2kvm可以直接识别并转换“img.gz”压缩格式的固件文件，对于“xxx.img.gz”来说，只需要输入“xxx.img”作为名称即可，不需要再另外加“.gz”。
vm_id：是创建好的OW虚拟机的ID。一般为一组非零开头的数字，如200。
vmdisk_name：是OW虚拟机要使用的磁盘名称。建议采用vm-<vm_id>-disk-<disk_id>的命名方式，如vm-200-disk-1。
storage：是指导入使用的存储池的ID，默认为“local-lvm”，这是安装PVE时自动创建的。此项为可选项，若不指定则使用默认值。
