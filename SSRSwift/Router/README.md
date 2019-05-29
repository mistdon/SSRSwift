# Router(路由)

### 路由的配置

###### 1.1   首先在info.plist中添加URL types，在Item 0中将默认的URl identifier 改成 URL Schemes ，并将值改成你的module name(我的项目中定义为SSRSwift).  ![](/Users/shendong/Documents/github/SSRSwift/SSRSwift/Router/sources/urlSchemes.png)
测试一下，在Safair中输入 SSRSwift:// 就可以打开我们的App了

###### 1.2  在一个iOS App中打开另外一个App
  1.2.1  设置白名单: 在info.plist中添加 `LSApplicationQueriesSchemes`,然后添加自定义的URL Scheme，比如`SSRSwift`.
  1.2.2  然后在另一个app中添加以下代码，以打开scheme名为`SSRObjc`的app
```swift
  SSRRouterViewController.openCustomeURLScheme("SSRObjc://")
```

### 现有路由的方案

### 未能解决的问题

### 思路

### 方案

### 参考链接
- [How to open iOS app with custom url](https://kitefaster.com/2016/07/13/how-to-open-ios-app-with-custom-url/)
