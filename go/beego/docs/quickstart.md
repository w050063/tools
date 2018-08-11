> https://beego.me/docs/quickstart/

# bee 工具新建项目
```
bee new quickstart
cd quickstart
bee run
```
http://127.0.0.1:8080/

# 路由设置
# controller 运行机制
输出字符串
```
func (this *MainController) Get() {
        this.Ctx.WriteString("hello")
}
```
# model 逻辑

# view 渲染
https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/07.4.md
# 静态文件处理
- 设置下载
