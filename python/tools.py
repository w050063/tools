#!/usr/bin/env python
# _*_ coding: utf-8 _*_

# example 01 time
import time

today_time = time.strftime("%Y%m%d%H%M%S", time.localtime())
now_time = time.strftime("%Y%m%d", time.localtime())
print today_time
print now_time

# example 01: file dir
import os


def mk_dir(dir_name):
    """
    创建目录函数，存在就提示，不存在就创建
    :param dir_name:
    :return:
    """
    is_exist = os.path.exists(dir_name)
    if not is_exist:
        print "%s is starting create" % (dir_name,)
        os.mkdir(dir_name)
    else:
        print "%s is ok" % (dir_name,)

mk_dir("backup")

# example 03: write read file
template_context = """svrIp=ip_list
step=1,2,3,4,5,6,7,8
svrFix=server_name_list
dbname=db_name_list
idConflictIndex=
mergeJDBC=true
testacc=
//1.清除索引2.清空表3.删除死号4.回城5.重名处理6.合并表格7.添加索引8.其他合服后的逻辑处理
"""

template_file = "merge.properties.template"
f = open(template_file, "w")
f.write(template_context)
f.close()

'r'：读
'w'：写
'a'：追加
'r+' == r+w（可读可写，文件若不存在就报错(IOError)）
'w+' == w+r（可读可写，文件若不存在就创建）
'a+' == a+r（可追加可写，文件若不存在就创建）
对应的，如果是二进制文件，就都加一个b就好啦：
'rb'　　'wb'　　'ab'　　'rb+'　　'wb+'　　'ab+'

# example 04: 拼接字符串
db_name_list = ["wg_lj", "test_lj"]
db_name_list = ','.join(db_name_list)
print db_name_list

# example 05: API
import urllib2
try:
    import json
except:
    import simplejson as json

url ="xxx"
data = urllib2.urlopen(url).read()
json_data = json.loads(data)
print json_data

# example 06: 计算求和
"""
数据格式 列表
a 1
b 2
c 3
a 2

处理后
a 3
b 2
c 3
"""
a = [["a", "1"], ["b", "2"], ["c", "3"], ["a", "2"], ]
print a
d = {}
for item in a:
    if item[0] in d:
        d[item[0]] += int(item[1])
    else:
        d[item[0]] = int(item[1])

print d
for key, value in d.items():
    print key, value

# example 07: http代理
"""
http 代理
python 2 使用urllib2, requests
python 3 使用urllib, requests
"""

import urllib2
proxy_handler = urllib2.ProxyHandler({'http': '203.174.112.13:3128'})
opener = urllib2.build_opener(proxy_handler)
r = opener.open('http://httpbin.org/ip')
print(r.read())

import requests
proxies = {"http": "http://60.168.80.199:808", "https": "http://183.56.131.87:3128", }
info = requests.get("http://httpbin.org/ip", proxies=proxies)
print(info.text)


import urllib.request
proxy_support = urllib.request.ProxyHandler({'http': '60.168.80.199:808'})
opener = urllib.request.build_opener(proxy_support)
urllib.request.install_opener(opener)
a = urllib.request.urlopen("http://httpbin.org/ip").read().decode("utf8")
print(a)

# example 08: json数据的文件写入读取
import json
import time


def store(data):
    with open('data.json', 'w') as json_file:
        json_file.write(json.dumps(data))


def load():
    with open('data.json') as json_file:
        data = json.load(json_file)
        return data

if __name__ == "__main__":

    data = {}
    data["last"] = time.strftime("%Y%m%d")
    store(data)

    data = load()
    print data["last"]
