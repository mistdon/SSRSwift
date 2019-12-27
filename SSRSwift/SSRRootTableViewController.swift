//
//  SSRRootTableViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import RxSwift

struct SSRTestStruct {
    var title: String?
    var subTitle: String?
    var closure: () -> Void
}
class SSRRootTableViewController: UITableViewController {
    var choicesArray = [SSRTestStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SSRSwift"
        choicesArray = [SSRTestStruct(title: "Network", subTitle: nil, closure: { [weak self] in
            self?.navigationController?.show(SSRHTTPViewController(), sender: nil)
        }), SSRTestStruct(title: "WKWebView", subTitle: "combine", closure: { [weak self] in
            let webVC = SSRWebViewController(url: "https://m.huamengxiaoshuo.com")
            self?.navigationController?.show(webVC, sender: nil)
        }), SSRTestStruct(title: "WKWebViewTest", subTitle: nil, closure: { [weak self] in
            let webVC = SSRWebViewController(url: "https://m.huamengxiaoshuo.com")
            self?.navigationController?.show(webVC, sender: nil)
        }), SSRTestStruct(title: "RxSwift", subTitle: nil, closure: { [weak self] in
            self?.navigationController?.show(SSRRxSwiftViewController(), sender: nil)
        }), SSRTestStruct(title: "Router", subTitle: nil, closure: { [weak self] in
            self?.navigationController?.show(SSRRouterViewController(), sender: nil)
        }), SSRTestStruct(title: "Adapor", subTitle: nil, closure: { [weak self] in
            self?.navigationController?.show(AdaptorUIViewController(), sender: nil)
        })]
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choicesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let choice: SSRTestStruct = choicesArray[indexPath.row]
        cell.textLabel?.text = choice.title
        cell.detailTextLabel?.text = choice.subTitle
        return cell
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let test = choicesArray[indexPath.row]
        test.closure()
    }
}
extension UIViewController{
    private struct AssociateKeys{
        static var nameKey = "nameKey"
    }
    var name: String?{
        set{
            objc_setAssociatedObject(self, &AssociateKeys.nameKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, &AssociateKeys.nameKey) as? String
        }
    }
}

/*
 
 if localSource {
     let bundleURL = Bundle.main.resourceURL!.absoluteURL
     let url = bundleURL.appendingPathComponent("index.html")
     wkWebView?.loadFileURL(url, allowingReadAccessTo: bundleURL)
 }else{
     url = URL(string: "https://www.baidu.com")
     loadUrl(url: url ?? URL(string: "about:blank")!)
 }
 
 
 */
