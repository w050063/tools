#
- 下载网站所有网页
  > wget -m http://www.example.com/

- 遇到下载首页后退出的情况,如何排查原因
  > wget -d debug -m http://www.example.com/
  
- 忽略robots.txt协议
  > wget -m -e robots=off http://www.example.com/
