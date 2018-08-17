# 常用包列表
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
