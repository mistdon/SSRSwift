//
//  SSRHTTPViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class SSRHTTPViewController: UIViewController {
    let cellIdentifier = "reuseIdentifier"
    let testApi = "https://api.github.com/users/mistdon/following"
    let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var followers = [SSRGithubFollower]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SSRGithubFollowerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        print(testApi)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let action = #selector(SSRHTTPViewController.tappedButton(_:))
        myButton.addTarget(self, action: action, for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func startRequest(_ sender: Any) {
        Alamofire.request(testApi).response { (dataResponse) in
            if let json = try? JSON(data: dataResponse.data!){
                let arr = json.arrayObject
                if let arr = arr{
                    for dict in arr{
                        let follower: SSRGithubFollower = SSRGithubFollower(with: dict as? [String : Any])
                        let follower2: SSRGithubFollower = SSRGithubFollower.deserialize(from: dict as? [String : Any])!
//                        self.followers.append(follower)
                        self.followers.append(follower2)
                    }
                    print(self.followers)
                    self.tableView.reloadData()
                }
            }
        }
    }
    @objc func tappedButton(_ sender: UIButton?){
        print("Tapped button")
    }

}
extension SSRHTTPViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SSRGithubFollowerCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! SSRGithubFollowerCell
        let follower = followers[indexPath.row]
        cell.nicknameLabel.text = follower.login
        cell.avatarImageView.sd_setImage(with: URL(string: follower.avatar_url!), completed: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followers.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let follower = self.followers[indexPath.row]
        let alertVC = UIAlertController(title: follower.login, message:"Hello, \(String(describing: follower.login))", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
