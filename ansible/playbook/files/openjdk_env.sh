#!/bin/env bash

sed -i '/# JAVA bin PATH setup/d' /etc/profile ~/.bashrc
sed -i '/jdk1.8.0_171/d' /etc/profile ~/.bashrc
sed -i '/JAVA_HOME/d' /etc/profile ~/.bashrc
sed -i '/JRE_HOME/d' /etc/profile ~/.bashrc
sed -i '/CLASSPATH/d' /etc/profile ~/.bashrc

cat>>/etc/profile<<EOF

# JAVA bin PATH setup
export JAVA_HOME=/usr/java/jdk1.8.0_171
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
source /etc/profile

cat>>~/.bashrc<<EOF

# JAVA bin PATH setup
export JAVA_HOME=/usr/java/jdk1.8.0_171
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
source ~/.bashrc
