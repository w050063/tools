###
### Go Web框架
- https://github.com/gin-gonic/gin
### Go环境安装
``` bash
wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
tar -zxf go1.10.1.linux-amd64.tar.gz -C /usr/local/
cat>>/etc/profile<<EOF

# setup go path env
export PATH=$PATH:/usr/local/go/bin
export GOPATH="/data0/workspaces/go"
EOF
source /etc/profile
go env
mkdir -p /data0/workspaces/go
```
### Go Get问题
- [代理方案](https://blog.csdn.net/wdy_yx/article/details/53045084)
- https://github.com/golang/

``` bash
https://github.com/MXi4oyu/golang.org
源：go get golang.org/x/tools/cmd/goimports
新：go get github.com/MXi4oyu/golang.org/x/toos/cmd/goimports
```

### 模块
- gofmt: 源代码格式化
- os：命令行
- https://github.com/golang/lint
- https://github.com/mozillazg/request
- 日志
https://github.com/mozillazg/logrus

### FQA
- go项目搜索：https://gowalker.org/

### 参考资料
- [Go语言圣经](https://books.studygolang.com/gopl-zh/index.html)
  - [示例代码](github.com/adonovan/gopl.io/)
