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
            SSRNaviChoic(title: "RxSwift", subTitle: "RxSwift & RxCocoa",vcClass:nil)
        ]
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(goToNextVC(at:)), for: .touchUpInside)
        
//        view.rx.observe(CGRect.self, "frame").sub
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return choicesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let choice: SSRNaviChoic = choicesArray[indexPath.row]
        cell.textLabel?.text = choice.title
        cell.detailTextLabel?.text = choice.subTitle
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToNextVC(at: indexPath)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func goToNextVC(at indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            let httpVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SSRHTTPViewController")
            self.navigationController?.show(httpVC, sender: nil)
        case 1:
            let webVC = SSRWebViewController()
            self.navigationController?.show(webVC, sender: nil)
        case 2:
            let webVC = SSRRxSwiftViewController()
            self.navigationController?.show(webVC, sender: nil)
        default:
            print("No match viewController.")
        }
    }

}
