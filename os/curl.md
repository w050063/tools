# curl
## curl常用案例
- 发邮件
    - 确认curl版本是否支持smtp协议
    > # curl-config --protocols | grep SMTP
    
    - curl-config安装
    > # yum install -y libcurl-devel
    
    - 使用语法
    > # cat mail.txt
    From:dongsheng.ma@lemongrassmedia.cn
    To:1455975151@qq.com
    Subject: curl发送邮件标题

  这里是内容，上面有一个空行别忘记了
  # curl -s --url "smtp://smtp.exmail.qq.com" --mail-from "dongsheng.ma@lemongrassmedia.cn" --mail-rcpt "1455975151@qq.com" --upload-file mail.txt --user "dongsheng.ma@lemongrassmedia.cn:xxx"

  ```
- 请求API
  ``` bash 
  curl -u xxx:xxx --head http://127.0.0.1:9000/api
  curl -u xxx:xxx -H 'Accept: application/json' -X GET 'http://127.0.0.1:9000/api/cluster?pretty=true'
  ```
## 参考资料
- [curl酷炫技巧:使用curl命令发送邮件](https://www.hi-linux.com/posts/54000.html)
