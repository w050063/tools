###
## Git 常用指令
``` bash
git status          # 查看修改文件
git add config.js   # 添加准备提交的文件(添加到本地)
git commit -m "update test"

git config --global user.name "mds1455975151"	      # 全局git添加用户
git config --global user.email "1455975151@qq.com"	#全局git添加邮箱


git config --local user.name "dongsheng.ma"                       # 单个仓库git添加用户
git config --local user.email "dongsheng.ma@lemongrassmedia.cn"   # 单个仓库git添加邮箱

git commit -m "update test"
git pull                # 更新别人的到本地
git push                # 提交到网络
git branch -a	          # 查看分支
git checkout dev	       # 切换到dev分支
git merge dev           # 将dev分支合并到当前分支
git push origin dev_seckill   # 提交分支
git branch -d dev             # 删除本地dev分支
git push origin --delete dev  # 删除本地分支传送到远端
git stash                     # 保存当前修改
git stash pop                 # 将修改恢复

# 修改远程URL地址
git remote -v
git remote set-url origin https://github.com/mds1455975151/tools.git
```
## 生成ssh密钥
``` bash
ssh-keygen -t rsa -C "your_email@example.com"
```
