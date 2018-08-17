###
### Go概述
- [GoLang官网](https://golang.org/)
- [GoLang中国](https://www.golangtc.com/)

### Go Web框架
- https://github.com/gin-gonic/gin
### Go环境安装
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/go/go_install.sh
sh go_install.sh
```
### Go Get问题
- [代理方案](https://blog.csdn.net/wdy_yx/article/details/53045084)
- https://github.com/golang/

``` bash
https://github.com/MXi4oyu/golang.org
源：go get golang.org/x/tools/cmd/goimports
新：go get github.com/MXi4oyu/golang.org/x/toos/cmd/goimports

alias goget='env http_proxy=127.0.0.1:1080 https_proxy=127.0.0.1:1080 go get -v -u'
在使用go包管理工具如dep时候，我们也会遇到类似情况，可以仿照上面的命令：
alias depp="env http_proxy=127.0.0.1:1080 https_proxy=127.0.0.1:1080 dep prune -v"
alias depea="env http_proxy=127.0.0.1:1080 https_proxy=127.0.0.1:1080 dep ensure -add -v"
alias depeu="env http_proxy=127.0.0.1:1080 https_proxy=127.0.0.1:1080 dep ensure -update -v"
alias depe="env http_proxy=127.0.0.1:1080 https_proxy=127.0.0.1:1080 dep ensure -v"
```

### 模块
- gofmt: 源代码格式化
- os：命令行
- https://github.com/golang/lint
- https://github.com/mozillazg/request
- 日志
  - https://github.com/mozillazg/logrus
- 包管理
  - http://glide.sh/
- golint
https://github.com/golang/lint
- goimporter
go vet是一个用于检查Go语言源码中静态错误的简单工具
- mysq
https://github.com/siddontang/go-mysql
- github.com/spf13/cobra/cobra 命令行
- github.com/logrusorgru/aurora 终端颜色

- 命令行库：github.com/spf13/cobra
``` bash
go get -v github.com/spf13/cobra/cobra
cobra.exe init demo 基于$GOPATH路径下开始
```
- 读取各类配置文件：github.com/spf13/viper
- 依赖管理：github.com/kardianos/govendor
``` bash
go get github.com/kardianos/govendor
cd $GOPATH/src/github.com/mds1455975151/cmdb
govendor init
govendor list
govendor.exe fetch github.com/sirupsen/logrus  
```
- 记录log
  - https://github.com/sirupsen/logrus
  - github.com/heirko/go-contrib/logrusHelper

  ``` bash
  go get -u github.com/sirupsen/logrus
  import github.com/sirupsen/logrus
  logo='我是要被记录的log信息'
  logrus.Info(logo)

  govendor.exe fetch github.com/heirko/go-contrib/logrusHelper
  ```
 - Go ORM
  - https://github.com/jinzhu/gorm
 ``` bash
  govendor.exe fetch github.com/jinzhu/gorm
  连接操作数据库需要两类包：1、ORM 2、数据库驱动

mysql
import _ "github.com/go-sql-driver/mysql"
为了方便记住导入路径，GORM包装了一些驱动。
import _ "github.com/jinzhu/gorm/dialects/mysql"
// import _ "github.com/jinzhu/gorm/dialects/postgres"
// import _ "github.com/jinzhu/gorm/dialects/sqlite"
// import _ "github.com/jinzhu/gorm/dialects/mssql"
 ```

go import用法
import "fmt"最常用的一种形式
import "./test"导入同一目录下test包中的内容
import f "fmt"导入fmt，并给他启别名ｆ
import . "fmt"，将fmt启用别名"."，这样就可以直接使用其内容，而不用再添加ｆｍｔ，如fmt.Println可以直接写成Println
import  _ "fmt" 表示不使用该包，而是只是使用该包的init函数，并不显示的使用该包的其他内容。注意：这种形式的import，当import时就执行了fmt包中的init函数，而不能够使用该包的其他函数。
- api文档
  - https://swagger.io/
  - github.com/swaggo/gin-swagger
  - github.com/swaggo/swag
- 数据库：github.com/go-sql-driver/mysql
- HTTP框架：https://github.com/gin-gonic/gin
  - 案例：https://github.com/gin-gonic/gin/tree/master/examples
### FQA
- go项目搜索：https://gowalker.org/

### 参考资料
- 资料汇总
  - [Go语言圣经](https://books.studygolang.com/gopl-zh/index.html)
  - [示例代码](github.com/adonovan/gopl.io/)
  - https://github.com/jobbole/awesome-go-cn
  - https://github.com/Unknwon/the-way-to-go_ZH_CN
  - godoc
  ```
  godoc -http=:6060
  ```
  - [官网教程](https://tour.go-zh.org/welcome/1)
- 项目汇总
  - https://github.com/EDDYCJY/blog
  - https://getqor.com/cn go语言实现电商系统
  - https://github.com/linclin/gopub 运维发布系统 学习go语言案例
  - https://github.com/ljb-2000/DockerPlatform  学习go语言案例
  - https://github.com/flike/kingshard
  - https://github.com/datacharmer/dbdeployer
  - https://github.com/astaxie/build-web-application-with-golang
  - https://github.com/hackstoic/golang-open-source-projects
  - https://github.com/avelino/awesome-go
  - https://github.com/george518/PPGo_Job 定时任务系统
  - https://github.com/gopherchina/conference Go 语言实际项目应用的技术分享
  - https://github.com/pingcap/tidb
  - https://github.com/gocn/knowledge Go社区的知识图谱
  - https://gobyexample.com/
### Go开发环境的基本要求
- 语法高亮
- 自动保存代码
- 可以显示代码所在的行数
- 拥有较好的项目文件浏览和导航能力，可以同时编辑多个源文件并设置书签，能够匹配括号，能够跳转到某个函数或类型的定义部分。
- 查找和替换功能，替换之前预览
- 注释和取消一行或多行代码
- 有编译错误时，双击错误提示可以跳转到发生错误的位置
- 跨平台，在linux、mac os和window下，可以专注于一个开发环境
- 免费
- 开源
- 能够通过插件架构来轻易扩展和替换某个功能
- 操作方便
- 通过代码模板简化编码过程从而提升编译速度
- 构建系统概念
- 断点、检查变量、单步执行、逐过程执行标识库中代码的能力
- 方便的存取最近使用过的文件或项目
- 对包、类型、变量、函数和方法的智能补全功能
- 对项目或包代码建立抽象语法树视图（AST-view）
- 内置go相关工具
- 方便完整查阅go文档
- 方便在不同go环境之间切换
- 导出不同格式的代码文件，例如PDF,HTML或格式化都的代码
- 针对特定的项目有模板，如：web应用，app Engine项目，从而能够更快的开始开发工作
- 具备代码重构的能力
- 集成git等版本控制工具
- 集成google app engine开发及调试的功能
