#!/bin/env bash

sed -i '/# Ant bin PATH setup/d' /etc/profile ~/.bashrc
sed -i '/ANT_HOME/d' /etc/profile ~/.bashrc

cat>>/etc/profile<<EOF

# Ant bin PATH setup
export ANT_HOME=/usr/local/ant
export PATH=\$PATH:\$ANT_HOME/bin
EOF
source /etc/profile

cat>>~/.bashrc<<EOF

# Ant bin PATH setup
export ANT_HOME=/usr/local/ant
export PATH=\$PATH:\$ANT_HOME/bin
EOF
source ~/.bashrc
