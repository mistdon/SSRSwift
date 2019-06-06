# WKWebView
WKWebView是在iOS8之后推出的新的WebView内核，用来取代之前的UIWebView


### 配置
1. 虽然苹果建议WebView的请求都使用https，但保留了http的权限。如果需要加载HTTP请求，在info.plist中添加
```json
/*
     
     <key>NSAppTransportSecurity</key>
     <dict>
        <key>NSAllowsArbitraryLoadsInWebContent</key>
        <true/>
     </dict>
*/
```
### 和JS的交互


### 如何优化？

1. 首次加载较慢

2. 偶现的白屏




### 其他点
 - Chrome for iOS 的内核采用的也是WKWebView

### TODO：
 1. WKWebView的自动登录？

- 如果你觉的部分代码对你有用，求Star😄
- 如果你觉的代码有问题？请提issue，或者直接和我沟通🙏

