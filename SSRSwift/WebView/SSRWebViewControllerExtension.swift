//
//  SSRWebViewControllerExtension.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/4/27.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import Foundation

let handleKey = "URLProtocolHandleKey"

class SSRUrlProtocol: URLProtocol {
    // 判断当前protocol, 是否要对着干requet进行处理
    override class func canInit(with request: URLRequest) -> Bool {
        guard let host = request.url?.host else { return false }
        if host == "api.shendong.store" {
            return false
        }
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    /// 重写这个方法，拦截请求后在此处理本地的资源, 并返回给webView
    override func startLoading() {
        URLProtocol.setProperty(true, forKey: handleKey, in: self.request as! NSMutableURLRequest)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "replace", ofType: "html")!)
        guard let data = try? Data.init(contentsOf: url) else { return }
        let response = URLResponse(url: self.request.url!, mimeType: "html", expectedContentLength: data.count, textEncodingName: nil)
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
        self.client?.urlProtocol(self, didLoad: data)
        self.client?.urlProtocolDidFinishLoading(self)
    }
}

extension SSRWebViewController {
    /// URL Protocol 拦截
    func urlProtocol() {
        URLProtocol.registerClass(SSRUrlProtocol.self)
    }
}
