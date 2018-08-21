- 文件下载
```
#requires -Version 3
 
$nas_scripts = 'https://raw.githubusercontent.com/mds1455975151/tools/master/synology/nas.reg'
$Destination = "nas.reg"
Invoke-WebRequest -Uri $nas_scripts -OutFile $Destination -UseBasicParsing
 
Invoke-Item -Path $Destination
```
