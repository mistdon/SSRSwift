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
    var vcClass: UIViewController?
}


class SSRRootTableViewController: UITableViewController {
    
    var choicesArray = [SSRNaviChoic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#file)
        choicesArray = [
            SSRNaviChoic(title: "HTTP", subTitle: "Request", vcClass: nil),
            SSRNaviChoic(title: "WebView", subTitle: "WebView request and handle",vcClass:nil),
            SSRNaviChoic(title: "RxSwift", subTitle: "RxSwift & RxCocoa",vcClass:nil),
            SSRNaviChoic(title: "Route", subTitle: "Router",vcClass:nil)
        ]
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(goToNextVC(at:)), for: .touchUpInside)
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
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("start....")
        print(self.name)
        self.name = "shen"
        print(self.name)
        print("end....")
        return
        goToNextVC(at: indexPath)
    }
    @objc func goToNextVC(at indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            let httpVC = SSRHTTPViewController()
            self.navigationController?.show(httpVC, sender: nil)
        case 1:
            let webVC = SSRWebViewController()
            self.navigationController?.show(webVC, sender: nil)
        case 2:
            let webVC = SSRRxSwiftViewController()
            self.navigationController?.show(webVC, sender: nil)
        case 3:
            let webVC = SSRRouterViewController()
            self.navigationController?.show(webVC, sender: nil)
        default:
            print("No match viewController.")
        }
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
