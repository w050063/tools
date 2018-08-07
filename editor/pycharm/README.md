# PyCharm配置
- 配置svn
```
配置步骤:
1. 打开PyCharm一次鼠标左键点击VCS->Browse repository using VCS ->Browse Subversion Repository在弹出的New Repository Location对话框内填写你SVN的url地址，如http://localhost/svn.
2. 右键点击你要导出的项目文件夹，在弹出的菜单里选择Checkout.
3. 指定导出存储位置。
打开刚才导出的目录，然后就可以在里面写代码然后提交到svn库了。

报错: SVN checkout项目时候会出现如下错误：Cannot load supported formats: Cannot run program "svn"
![images](01.png)
```
