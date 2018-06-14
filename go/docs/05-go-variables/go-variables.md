> Go语言变量

# 变量声明
``` bash
package main
var a = "菜鸟教程"
var b string = "runoob.com"
var c bool

func main(){
    println(a, b, c)
}
```
# 多变量声明

# 值类型和引用类型

# 如何判断变量的类型
- 方法1

```
package main

import (
 "fmt"
)

func main() {

        v1 := "123456"
        v2 := 12

        fmt.Printf("v1 type:%T\n", v1)
        fmt.Printf("v2 type:%T\n", v2)
}
```
output:
> v1 type:string
v2 type:int

- 方法2

```
package main

import (
 "fmt"
 "reflect"
)

func main() {
        v1 := "123456"
        v2 := 12

        // reflect
        fmt.Println("v1 type:", reflect.TypeOf(v1))
        fmt.Println("v2 type:", reflect.TypeOf(v2))
}
```
output
> v1 type:string
v2 type:int
