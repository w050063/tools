# Powershell

- 概述
> Windows PowerShell 是专为系统管理员设计的新 Windows 命令行外壳程序。该外壳程序包括交互式提示和脚本环境，两者既可以独立使用也可以组合使用。
与接受和返回文本的大多数外壳程序不同，Windows PowerShell 是在 。NET 公共语言运行时 (CLR) 和 。NET Framework 的基础上构建的，它接受和返回 。NET 对象。环境中的这一根本更改带来了管理和配置 Windows 的全新工具和方法。

- 查看PowerShell版本
> $PSVersionTable

- 查看安装的.Net framework版本信息
> $PSVersionTable.CLRVersion

- 文件下载
```
#requires -Version 3

$nas_scripts = 'https://raw.githubusercontent.com/mds1455975151/tools/master/synology/nas.reg'
$Destination = "nas.reg"
Invoke-WebRequest -Uri $nas_scripts -OutFile $Destination -UseBasicParsing

Invoke-Item -Path $Destination
```

```
start

@echo off
color A
tree

cls

```
# 参考资料
- PowerShell中文博客：https://www.pstips.net/
