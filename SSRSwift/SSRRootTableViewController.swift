//
//  SSRRootTableViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import RxSwift

struct SSRNaviChoic {
    var title: String?
    var subTitle: String?
    var vcClass: UIViewController.Type
}


class SSRRootTableViewController: UITableViewController {
    
    var choicesArray = [SSRNaviChoic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SSRSwift"
        VLog(#file)
        choicesArray = [
            SSRNaviChoic(title: "HTTP网络库", subTitle: "Request", vcClass: SSRHTTPViewController.self),
            SSRNaviChoic(title: "WebView封装和实战", subTitle: "WebView request and handle",vcClass:SSRWebViewController.self),
            SSRNaviChoic(title: "RxSwift", subTitle: "RxSwift & RxCocoa",vcClass:SSRRxSwiftViewController.self),
            SSRNaviChoic(title: "Route", subTitle: "Router",vcClass:SSRRouterViewController.self),
            SSRNaviChoic(title: "Adaptor", subTitle: "Adaptor各种适配",vcClass:AdaptorUIViewController.self)
        ]
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
        let choice: SSRNaviChoic = choicesArray[indexPath.row]
        cell.textLabel?.text = choice.title
        cell.detailTextLabel?.text = choice.subTitle
        return cell
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navi = choicesArray[indexPath.row]
        let controller = navi.vcClass
        let vc = controller.init()
        self.navigationController?.show(vc, sender: nil)
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

