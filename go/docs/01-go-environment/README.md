下载地址：https://golang.org/dl/

# Go安装
## windows:
### Install the Go tools
[安装及配置方法](https://golang.org/doc/install?download=go1.10.windows-amd64.msi)
## Test your installation
``` bash
$ cat test.go
package main

import "fmt"

func main(){
  fmt.Println("Hello,world!")
}

$ go run test.go
Hello,world!

```

## Linux
待补充
## Mac OS X
``` bash
brew install go
brew info go
```

# Go 命令说明
- go build
- go run:编译并运行Go程序
- go install
- go clean
- go fmt
- go get:动态获取远程代码包
- go test
- go doc
- go version
- go env
- go list


# GoGetTools
https://github.com/golang/go/wiki/GoGetTools

# IDE推荐
- JetBrains GoLand(依赖JDK)
https://www.jetbrains.com/go/?fromMenu
- LiteIDE
- Eclipse
- Sublime Text
- Vim
- Emacs
# 格式化代码
- gofmt
```
gofmt -w a1.go  # 格式化并重写go源文件
gofmt -w *.go
gofmt dir1      # 格式化并重写dir1目录及其子目录下的所有go源文件


```
