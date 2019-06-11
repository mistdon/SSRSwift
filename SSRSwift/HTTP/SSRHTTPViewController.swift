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

let API_URL = "https://api.github.com/search/repositories?q=ss"

let testApi = "https://api.github.com/users/mistdon/following"

let switchCaseOpen = false

class SSRHTTPViewController: UIViewController {
    let cellIdentifier = "reuseIdentifier"
    let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var followers = [SSRGithubFollower]()
    var repositories = [GithubRepository]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SSRGithubFollowerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        print(testApi)
    
        let button = UIButton(frame: CGRect(x: 10, y: 200, width: 200, height: 50))
        button.setTitle("Touch me", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc func keyboardWillShow() {
        print(#function)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let action = #selector(SSRHTTPViewController.tappedButton(_:))
        myButton.addTarget(self, action: action, for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        print("http deinit")
    }
    @IBAction func startRequest(_ sender: Any) {
        if switchCaseOpen {
            Alamofire.request(API_URL).responseString { response in
                switch(response.result){
                case .success(let responseString):
                    print(responseString)
                    let response  = GithubRepositoryResponse(JSONString: responseString)
                    print(response as Any)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            Alamofire.request(testApi).responseString { response in
                switch(response.result){
                case .success(let responseString):
                    print(responseString)
                    if let followers = [SSRGithubFollower].deserialize(from: responseString){
                        print(followers)
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
//        Alamofire.request(API_URL).response { (dataResponse) in
//            if let json = try? JSON(data: dataResponse.data!){
//                let arr = json.arrayObject
//                if let arr = arr{
//                    for dict in arr{
//                        let follower: SSRGithubFollower = SSRGithubFollower(with: dict as? [String : Any])
////                        let follower2: SSRGithubFollower = SSRGithubFollower.deserialize(from: dict as? [String : Any])!
//                        self.followers.append(follower)
////                        self.followers.append(follower2)
//                    }
//                    print(self.followers)
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
    @objc func tappedButton(_ sender: UIButton?){
        // 1.
        SSRGithubFollower().requestMyFollowings(success: { (data) in
            if let data = data as? [SSRGithubFollower]{
                self.followers = data
                self.tableView.reloadData()
            }
        }) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        // 2.
        SSRGithubFollower().requestISFollowing("relatedcode", success: { (data) in

        }) { (error) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
        SSRGithubRepository().searchRepository("SSR", success: { data in
            let data = data as? SSRGithubRepositoryTotal
            print(data?.total_count as Any)
        }) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
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
