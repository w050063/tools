> Go语言流程控制语句

# 循环类型
- for
```
package main

import (
	"fmt"
)

func main() {
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}

```
- 循环嵌套
- if
```
package main

import (
	"fmt"
	"math"
)

func pow(x, y, n float64) float64 {
	if x := math.Pow(x, y); x < n {
		return x
	}
	return n
}

func main() {
	fmt.Println(
		pow(2, 4, 15),
		pow(2, 4, 30),
	)
}
```
- if else
```
package main

import "fmt"

func sw( x, y float64)  string {
	if x > y {
		return "x>y"
	}else {
		return "x<y"
	}
	return "x=y"
}

func main()  {
	fmt.Println(
		sw(10, 30),
		sw(110,23),
	)
}
```

- switch
```
package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Print("Go runs on ")
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.", os)
	}
}

switch求值顺序

```

# 循环控制语句
- break
- continue
- goto

# 无限循环
如过循环中条件语句永远不为 false 则会进行无限循环，我们可以通过 for 循环语句中只设置一个条件表达式来执行无限循环：
```
package main

import "fmt"

func main() {
    for true  {
        fmt.Printf("这是无限循环。\n");
    }
}

案例
package main

import (
	"fmt"
	"time"
)

func main()  {
	for {
		fmt.Println("无限循环")
		time.Sleep(time.Duration(2)*time.Second)
	}
}
```
