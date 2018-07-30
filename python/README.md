# Python
My Python Example

# pip
``` bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```
# paramiko
- [paramiko多线程执行命令总结](https://github.com/mds1455975151/Python/blob/master/paramiko/paramiko_muti.md)
- [mail发邮件](http://www.runoob.com/python/python-email.html)

# 汉字拼音
- https://github.com/mozillazg/python-pinyin
- https://github.com/mozillazg/go-pinyin

# Python开发环境管理virtualenvwrapper
```
wget https://raw.githubusercontent.com/mds1455975151/tools/master/python/install_virtualenvwrapper.sh
sh install_virtualenvwrapper.sh
```

# 工具类
- nose执行单元测试
```
pip install nose
cd 到编写了单元测试用例的文件夹，单元测试用例的文件要以test开头,运行命令
nosetests -s test_xx.py   : 参数s表示可以输入测试用例文件里面的 print 这种程序输出

nosetests测试代码覆盖率
使用：
nosetests --with-coverage --cover-package=project1

修改Person 类的测试用例，查看输出报告的变化， 加强对测试代码覆盖率的理解
报告范例如下：
Name                    Stmts   Miss  Cover   Missing
-----------------------------------------------------
devops_project              0      0   100%   
devops_project.Person      10      3    70%   11, 14, 17
-----------------------------------------------------
TOTAL                      10      3    70%   
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK
```
- fabric进行部署
- pylint执行代码质量检测
```
安装
pip install pylint

检查安装
pylint --version

生成配置文件：
pylint --persistent=n --generate-rcfile > pylint.conf

指定分析某个文件：
pylint --rcfile=pylint.conf Person.py

指定分析某个项目文件夹：
cd  project_path;
pylint -r n project_path

分析报告的解读：
C表示convention，规范；
W表示warning，告警；

pylint结果总共有四个级别：
error，warning，refactor，convention
可以根据首字母确定相应的级别。1, 0表示告警所在文件中的行号和列号。
```

# 总结资料
- https://github.com/lijin-THU/notes-python
