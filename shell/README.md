# 主机初始化
``` bash
wget https://raw.githubusercontent.com/mds1455975151/tools/master/shell/host_init.sh
sh host_init.sh
```

# 常用变量
``` bash
$BASH_SOURCE-输出脚本名称
$0: 执行脚本的名字
$*和$@: 将所有参数返回
$#:参数的个数
$_:代表上一个命令的最后一个参数
$$:代表所在命令的PID
$!:代表最后执行的后台命令的PID
$?:代表上一个命令执行是否成功的标志，如果执行成功则$? 为0，否则不为0
```

- shell退出
    - exit 退出脚本

    - return 退出函数

    - break 中断整个循环

    - continue 退出本次循环
    
# 资料
- https://github.com/dylanaraps/pure-bash-bible
