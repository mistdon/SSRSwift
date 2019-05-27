//
//  SSRWebViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/9.
//  Copyright © 2019年 shendong. All rights reserved.
//
/*
     加载HTTP请求，需要在info.plist中添加
     <key>NSAppTransportSecurity</key>
     <dict>
        <key>NSAllowsArbitraryLoadsInWebContent</key>
        <true/>
     </dict>
*/

import UIKit
import WebKit
import RxSwift
import RxCocoa

class SSRWebViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    let disposeBag = DisposeBag()
    var localSource = false
    
    open var url: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SSRWebVC"
        view.backgroundColor = UIColor.white
        loadWebView()
        if localSource {
            url = Bundle.main.url(forResource: "index", withExtension: "html")
        }else{
            url = URL(string: "https://www.baidu.com")
        }
        loadUrl(url: url ?? URL(string: "about:blank")!)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        progressView.removeFromSuperview()
        progressView = nil
        webView.scrollView.delegate = nil
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
        print("WebView is dealloc")
    }
    // MARK: 初始化
    fileprivate func loadWebView(){
        // 加载WebView
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = WKUserContentController()
        // 这里添加messageHander的name,和JS的代码对应
        // window.webkit.messageHandlers.<name>.postMessage(<messageBody>)
        configuration.userContentController.add(self, name: "SSRSwift")
        
        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true // 打开后，用户可在webview内左滑返回上一级
        view = webView
//        if #available(iOS 11.0, *){
//            webView.scrollView.contentInsetAdjustmentBehavior = .never
//        }else{
//            automaticallyAdjustsScrollViewInsets = false
//        }
        // 加载ProgressView
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        if let naviVC = self.navigationController {
            var rect = progressView.frame
            rect.origin.y = naviVC.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
            rect.size.width = UIScreen.main.bounds.size.width
            progressView.frame = rect
        }
        view.addSubview(progressView)
        // 绑定事件
        bindActions()
    }
    fileprivate func bindActions(){
        // 处理title
        webView.rx.observe(String.self, #keyPath(WKWebView.title)).subscribe(onNext: { [weak self]  (value) in
            guard let title = value else {return}
            self?.title = title
        }).disposed(by: disposeBag)
        // 处理进度条
        webView.rx.observe(Double.self, #keyPath(WKWebView.estimatedProgress)).subscribe(onNext: {[weak self] (value) in
            guard let progess = value else {return}
            self!.progressView.progress = Float(progess)
            self!.progressView.isHidden = (progess == 1)
        }).disposed(by: disposeBag)
    }
    fileprivate func loadUrl(url: URL){
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    fileprivate func showAlert(message: String){
        let alertVC = UIAlertController(title: "Attention Please", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
extension SSRWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("sayHello('WebView!')") { (result, error) in
            if error != nil{
                print(result as Any)
            }
        }
    }
}
extension SSRWebViewController: WKUIDelegate{
    // 响应JS中的 alert() 方法
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        showAlert(message: message)
        completionHandler()
    }
}
extension SSRWebViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
