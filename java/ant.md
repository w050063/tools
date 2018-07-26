# Ant概述
Ant是一个用来构建Java程序的工具，和make与C语言的关系差不多。主要用来简化一系列操作的，通常编译Java程序你需要创建相关目录，添加第三方依赖，编译并生成相应的包文件。

# 部署安装
``` bash
wget http://apache.communilink.net//ant/binaries/apache-ant-1.10.3-bin.tar.gz
tar -zxf apache-ant-1.10.3-bin.tar.gz -C /usr/local/
cd /usr/local/ && ln -s apache-ant-1.10.3/ ant
cat>>/etc/profile<<EOF

# ant bin PATH setup
export ANT_HOME=/usr/local/ant
export PATH=${PATH}:${ANT_HOME}/bin
EOF
ant -version
```

# build.xml文件
