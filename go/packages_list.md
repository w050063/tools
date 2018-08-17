# 包管理
```
import "fmt"最常用的一种形式
import "./test"导入同一目录下test包中的内容
import f "fmt"导入fmt，并给他启别名ｆ
import . "fmt"，将fmt启用别名"."，这样就可以直接使用其内容，而不用再添加ｆｍｔ，如fmt.Println可以直接写成Println
import  _ "fmt" 表示不使用该包，而是只是使用该包的init函数，并不显示的使用该包的其他内容。注意：这种形式的import，当import时就执行了fmt包中的init函数，而不能够使用该包的其他函数。
```
# 常用包列表
- gofmt: 源代码格式化
- os：命令行
- https://github.com/golang/lint
- https://github.com/mozillazg/request
- 日志
  - https://github.com/mozillazg/logrus
- 包管理
	- govendor
	- gopm
	- glide包管理工具
			[官网地址](https://glide.sh/)
			```
			curl https://glide.sh/get | sh
			glide init
			edit glide.yaml
			glide update
			glide install
			glide get github.com/foo/bar
			glide get github.com/foo/bar#^1.2.3
			```
- golint
https://github.com/golang/lint
- goimporter
go vet是一个用于检查Go语言源码中静态错误的简单工具
- mysq
https://github.com/siddontang/go-mysql
- 命令行
	- github.com/spf13/cobra/cobra
	``` bash
	go get -v github.com/spf13/cobra/cobra
	cobra.exe init demo 基于$GOPATH路径下开始
	```
- 终端颜色
	- github.com/logrusorgru/aurora

- 配置管理
	- github.com/spf13/viper
- 依赖管理
	- github.com/kardianos/govendor
	``` bash
	go get github.com/kardianos/govendor
	cd $GOPATH/src/github.com/mds1455975151/cmdb
	govendor init
	govendor list
	govendor.exe fetch github.com/sirupsen/logrus  
	```
- 记录日志
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
- api文档
  - https://swagger.io/
  - github.com/swaggo/gin-swagger
  - github.com/swaggo/swag
- 数据库
	- github.com/go-sql-driver/mysql
- HTTP框架：https://github.com/gin-gonic/gin
  - 案例：https://github.com/gin-gonic/gin/tree/master/examples
- [runtime](https://golang.org/pkg/runtime/)
- [math/rand](#) 随机数
```
package main

import (
	"fmt"
	"math/rand"
	"time"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}
func main() {
	fmt.Println("My favorite number is", rand.Intn(10))

	for i := 0; i < 10; i++ {
		a := rand.Int()
		fmt.Println(a)
	}

	for i := 0; i < 10; i++ {
		a := rand.Intn(100)
		fmt.Println(a)
	}

	for i := 0; i < 10; i++ {
		a := rand.Float32()
		fmt.Println(a)
	}
}

```
- [time]() 时间
- [gopm](https://gopm.io/)
