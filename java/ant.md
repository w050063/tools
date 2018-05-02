``` bash 
wget http://apache.communilink.net//ant/binaries/apache-ant-1.10.3-bin.tar.gz
tar -zxf apache-ant-1.10.3-bin.tar.gz
cat>>/etc/profile<<EOF

# ant bin PATH setup
export ANT_HOME=/usr/local/ant
export PATH=${PATH}:${ANT_HOME}/bin
EOF
```
