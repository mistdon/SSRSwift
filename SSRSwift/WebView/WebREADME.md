# WKWebView

WKWebView是在`iOS8`之后推出的新的WebView内核，用来取代之前的UIWebView(在2020后，包含UIWebView的包将被Apple拒绝)

### 配置
1. 虽然苹果建议WebView的请求都使用https，但保留了http的权限。如果需要加载HTTP请求，在info.plist中添加
```json     
     <key>NSAppTransportSecurity</key>
     <dict>
        <key>NSAllowsArbitraryLoadsInWebContent</key>
        <true/>
     </dict>
```

### 和JS的交互


### 如何优化？

1. 首次加载较慢

2. 偶现的白屏


### Q & A

1. Q: 内存泄漏
内存泄漏有多种可能性，在示例工程中出现的一个泄漏是以下代码导致的:
```swift
 configuration.userContentController.add(self, name: SSRAppModuleName)
```
A: 通过以下方式解决
```swift 
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // 下面两行解决 configuration.userContentController.add(self, name: SSRAppModuleName) 导致的循环引用
    wkWebView.configuration.userContentController.removeScriptMessageHandler(forName:SSRAppModuleName)
    wkWebView.configuration.userContentController.removeAllUserScripts()
}
```

### 其他点
 - Chrome for iOS 的内核采用的也是WKWebView

### TODO：
 1. WKWebView的自动登录？


