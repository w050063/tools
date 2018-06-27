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
pip install virtualenv
pip install virtualenvwrapper
cat>>~/.bashrc<EOF
if [ `id -u` != '0' ]; then
  export VIRTUALENV_USE_DISTRIBUTE=1            # <-- Always use pip/distribute
  export WORKON_HOME=$HOME/.virtualenvs        # <-- Where all virtualenvs will be stored
  source /usr/local/bin/virtualenvwrapper.sh
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_RESPECT_VIRTUALENV=true
fi
EOF
source .bashrc
mkvirtualenv aardvark
```
