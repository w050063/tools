# 概述
- 官网地址：https://stedolan.github.io/jq/


``` shell
yum install -y jq

echo $aa|jq -r '.'
echo $aa|jq -r '.[0]'
echo $aa|jq -r '.[].ip'
```

# 参考资料
- [命令行JSON处理工具jq的使用介绍](https://www.ibm.com/developerworks/cn/linux/1612_chengg_jq/index.html?ca=drs-&utm_source=tuicool&utm_medium=referral)
