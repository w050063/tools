- 官网地址：https://beego.me/

# [快速入门](https://beego.me/quickstart)
## 安装
[Bee](github.com/beego/bee):bee工具是一个为了协助快速开发beego项目而创建的项目，通过bee您可以很容易的进行beego项目的创建、热编译、开发、测试、和部署。

```
$ go get -u github.com/astaxie/beego
$ go get -u github.com/beego/bee

$ cd $GOPATH/src
$ bee new hello
$ cd hello
$ bee run hello
```
这些指令帮助您：
- 安装 beego 到您的 $GOPATH 中。
- 在您的计算机上安装 Bee 工具。
- 创建一个名为 “hello” 的应用程序。
- 启动热编译。
一旦程序开始运行，您就可以在浏览器中打开 http://localhost:8080/ 进行访问。
