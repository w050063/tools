# 通过Git管理SVN代码
```
yum install -y git-svn
cd /data0/git/
git svn clone svn://10.0.0.23/test test
git svn clone file:///data0/svn/test test -s --prefix=svn/
git svn rebase

git clone --bare test test.git
git clone ssh://root@jenkins.dev.xxxx.cn:22/data0/git/test.git

svn->git-->提交到git remote--这边在使用
svn仓库转为git clone副本 设置钩子脚本，svn提交后更新git clone副本，并提交到git远程仓库

副本提交到gogs仓库
git svn rebase
git push origin master
ansible-ui使用
```
# 参考资料
- [git-svn: 通过git来管理svn代码](https://www.cnblogs.com/h2zZhou/p/6136948.html)
