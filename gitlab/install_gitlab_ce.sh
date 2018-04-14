#!/bin/env bash

data_dir="/data0/src"
app_version="gitlab-ce-10.6.4-ce.0.el7.x86_64.rpm"

[ ! -d ${data_dir} ] && mkdir -p ${data_dir}

if [ ! -f ${data_dir}/${app_version} ]
then
    cd ${data_dir} && wget https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/${app_version}
fi

rpm -ivh ${data_dir}/${app_version}
