//
//  SSRWebViewTestViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/27.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit

class SSRWebViewTestViewController: SSRWebViewController {
    lazy var consoleView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.textColor = .white
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add consoleView
        self.view.addSubview(self.consoleView)
        self.consoleView.snp_makeConstraints { make in
          make.leading.trailing.equalTo(self.view)
          make.bottom.equalTo(self.view.snp_bottom)
          make.height.equalTo(self.view.height / 3.0)
        }
    }
}
// 辅助调试方法
extension SSRWebViewTestViewController{
    fileprivate func showAlert(message: String){
        self.WKLog("Native show alert")
        let alertVC = UIAlertController(title: "Attention Please", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    fileprivate func sendToJavaScript(name: String, age: Int){
        wkWebView?.evaluateJavaScript("addPerson('\(name),\(age)')", completionHandler: nil)
    }
    fileprivate func WKLog(_ txt: String){
        self.consoleView.text.append(txt)
        self.consoleView.text.append("\n")
    }
}
