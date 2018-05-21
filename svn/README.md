# SVN相关问题
## SVN web管理工具
- [submin](https://supermind.nl/submin/)

## SVN权限设置
- 特殊账号($authenticated 代表所有用户)

- 特殊权限(* = 代表其他所有用户无任何权限)

## SVN权限管理
- qa_junior
- qa_senior
- qa_advanced

## SVN目录结构调整
目录结构调整，在不checkout所有代码的情况下如何快速调整
``` bash 
svn move -m "Move a dir" svn://xxx/dongsheng/test1/test_dir svn://xxx/dongsheng/test2/test_dir
svn move -m "Move a dir" file:///home/svn-root/dongsheng/test2/test_dir file:///home/svn-root/dongsheng/test1/test_dir
```
