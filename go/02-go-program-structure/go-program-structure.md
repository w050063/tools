> Go语言结构

# Go Hello World实例
GO语言的基础组成有以下几个部分：
- 包声明
- 引入包
- 函数
- 变量
- 语句 & 表达式
- 注释

> package main
>
> import "fmt"
>
> func main() {
   /* 这是我的第一个简单的程序 */
   fmt.Println("Hello, World!")
}

分析下以上程序的各个部分：

# 执行Go程序
``` text
$ go run hello.go
Hello, World!
```

# iota枚举
``` go
package main

import (
	"fmt"
)

func main(){
	const (
		x = iota
		y = iota
		z = iota
	)

	const v  = iota

	const (
		e,f,g = iota,iota,iota
	)
	fmt.Printf("x,y,z,v= %v,%v,%v,%v", x,y,z,v)
	fmt.Printf("\n")
	fmt.Printf("e,f,g = %v,%v,%v", e,f,g)
}

// iota 默认开始值为0，没调用一次加1
// 每遇到一个const关键字，iota就会重置变为0
```

# 数据 arrary
``` go
package main

import "fmt"

func main() {
	var arr [10]int			// 声明一个int类型的数组
	arr[0] = 10				// 赋值操作
	a := [3]int{1,2,3}		// 声明长度为3的数组，其中前三个元素初始化为1,2,3，其他默认为0
	c := [10]int{1,2,3}		// 声明一个长度为10的int
	b := [...]int{4,5,6}	// 可以省略长度采用...代表，go会自动根据元素个数计算长度
	fmt.Printf("arr:%v\n", arr)
	fmt.Printf("a:%v\n", a)
	fmt.Printf("b:%v\n", b)
	fmt.Printf("c:%v\n", c)
}
D:\go\src\test-01>go run 03.go
arr:[10 0 0 0 0 0 0 0 0 0]
a:[1 2 3]
b:[4 5 6]
c:[1 2 3 0 0 0 0 0 0 0]
```
# 注意
- 1、包名和包所在的文件夹名可以是不同的，此处的<pkgName>即为通过package <pkgName>声明的包名，而非文件夹名。
- 2、_（下划线）是个特殊的变量名，任何赋予它的值都会被丢弃

# 常见报错
- 1、go run: cannot run non-main package
原因：package 命名必须为main
- 2、syntax error: non-declaration statement outside function body
原因：在函数为定义了变量
