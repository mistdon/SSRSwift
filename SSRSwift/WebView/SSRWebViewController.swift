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
import SnapKit

class SSRWebViewController: BaseViewController {
    weak var wkWebView: WKWebView?
    private var progressView: UIProgressView?
    private let disposeBag = DisposeBag()
    open var urlString: String?
    lazy var cookiesMapArray: [String] = {
        let cookiesMapArray = ["app=SSRSwift","channel=appStore"]
        return cookiesMapArray
    }()
    convenience init(url: String?) {
        self.init()
        self.urlString = url
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Loading..."
        loadWebView()
        createUI()
        bindActions()
        guard let str = urlString, let url = URL(string: str) else{
            return
        }
        loadUrl(url: url)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 下面两行解决 configuration.userContentController.add(self, name: SSRAppModuleName) 导致的循环引用
        wkWebView?.configuration.userContentController.removeScriptMessageHandler(forName:SSRAppModuleName)
        wkWebView?.configuration.userContentController.removeAllUserScripts()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    deinit {
        progressView?.removeFromSuperview()
        wkWebView?.scrollView.delegate = nil
        wkWebView?.navigationDelegate = nil
        wkWebView?.uiDelegate = nil
        wkWebView?.removeFromSuperview()
        VLog("WebView deinit")
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
        configuration.userContentController.add(self, name: SSRAppModuleName)
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true // 打开后，用户可在webview内左滑返回上一级
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        wkWebView = webView
        webView.customUserAgent = SSRUserDefaults.string(key: UD_WKUserAgent)
        if #available(iOS 11.0, *){
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    func createUI(){
        // 加载ProgressView
        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.frame = CGRect(x: 0, y: 0, width: App.screenWidth, height: 0.5)
        progressView?.sizeToFit()
        view.addSubview(progressView!)
      
    }
    fileprivate func bindActions(){
        // 处理title
        wkWebView?.rx.observe(String.self, #keyPath(WKWebView.title)).subscribe(onNext: { [weak self]  (value) in
            guard let title = value else {return}
            self?.title = title
        }).disposed(by: disposeBag)
        // 处理进度条
        wkWebView?.rx.observe(Double.self, #keyPath(WKWebView.estimatedProgress)).subscribe(onNext: {[weak self] (value) in
            guard let progess = value else {return}
            self?.progressView?.progress = Float(progess)
            self?.progressView?.isHidden = (progess == 1)
        }).disposed(by: disposeBag)
    }
    fileprivate func loadUrl(url: URL){
        let request = URLRequest(url: url)
        self.wkWebView?.load(request)
    }
    fileprivate func reinjectCookie(){
        var injectCookieArray = [String]()
        
        cookiesMapArray.forEach { cookieKeyValue in
            let injectCookie = "document.cookie='\(cookieKeyValue);path=/;'"
            injectCookieArray.append(injectCookie)
        }
        let res = injectCookieArray.joined(separator: ",")
        self.wkWebView?.configuration.userContentController.removeAllUserScripts()
        let cookieScript = WKUserScript(source: res, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        self.wkWebView?.configuration.userContentController.addUserScript(cookieScript)
        self.reloadWebView()
    }
    fileprivate func appendCookies(request: NSMutableURLRequest) {
        let cookieString = self.cookiesMapArray.joined(separator: ",")
        request.setValue(cookieString, forHTTPHeaderField: "Cookie")
    }
    fileprivate func reloadWebView(){
        guard let url = self.wkWebView?.url else{
            return
        }
        let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20.0)
        appendCookies(request: request)
        self.wkWebView?.load(request as URLRequest)
    }
}
extension SSRWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.wkWebView?.evaluateJavaScript("document.cookie", completionHandler: { (cookie, error) in
            VLog("document.cookie = \(String(describing: cookie))")
        })
    }
    // 根据不同的请求，区分是否允许跳转。比如要对某个host进行限制，则选择 .cancel, 或者我们要对某些actionUrl进行自定义操作，也要拦截
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        let headers = request.allHTTPHeaderFields
        print(headers as Any)
        if request.url?.host == SSRAppModuleName {
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            self.navigationController?.show(vc, sender: nil)
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        
//    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        // WebView 被意外中断，比如白屏, 这里可以做一些过度操作，或者重试操作
        webView.reload()
    }
}
extension SSRWebViewController: WKUIDelegate{
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//
//    }
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    // 响应JS中的 alert() 方法
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
//    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
//        return false
//    }
//    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
//        return self
//    }
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        
    }
}
extension SSRWebViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let response = message.body as? String else { return }
        VLog(response)
    }
}

