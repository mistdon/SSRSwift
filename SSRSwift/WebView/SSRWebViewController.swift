//
//  SSRWebViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/9.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class SSRWebViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    let disposeBag = DisposeBag()
    open var url: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadWebView()
        // load url from url
//        url = URL(string: "https://www.hackingwithswift.com")
        // or load source from local html file
        self.title = "SSRWebVC"
        url = Bundle.main.url(forResource: "index", withExtension: "html")
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    deinit {
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
}
extension SSRWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("sayHello('WebView!')") { (result, error) in
            print(result, error)
        }
    }
}
extension SSRWebViewController: WKUIDelegate{
    // 响应JS中的 alert() 方法
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "Attention Please", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
        completionHandler()
    }
}
extension SSRWebViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
