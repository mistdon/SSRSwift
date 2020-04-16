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
import SnapKit
import FDFullscreenPopGesture
import RxCocoa
import RxSwift

private let testApi = "https://api.github.com/users/mistdon/following"

private let ywApi = "https://yapi.yuewen.com/mock/1166/api/v1/client/cloudConf"

class SSRHTTPViewController: BaseViewController {
    let cellIdentifier = "reuseIdentifier"
    let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var followers = [SSRGithubFollower]()
    var repositories = [GithubRepository]()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SSRNetwork.configur(timeoutInterval: 20)
//        SSRNetwork.shared.customHeaders  = [
//            "Accept": "applicaiton/json",
//            "DeviceInfo": "SSRSwift/iOS"
//        ]
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        tableView.register(UINib(nibName: "SSRGithubFollowerCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let button1 = UIBarButtonItem(title: "Reload", style: .done, target: nil, action: nil)
        button1.rx.tap.subscribe(onNext: { [weak self] in
            self?.requestFollowers()
        }).disposed(by: base_disposeBag)
        
        let button2 = UIBarButtonItem(title: "YWMock", style: .done, target: nil, action: nil)
        button2.rx.tap.subscribe(onNext: { [weak self] in
            self?.requestYWMock()
        }).disposed(by: base_disposeBag)
        
        let button3 = UIBarButtonItem(title: "Origin", style: .done, target: nil, action: nil)
        button3.rx.tap.subscribe(onNext: { [weak self] in
            self?.requestOrigin()
        }).disposed(by: base_disposeBag)
        self.navigationItem.rightBarButtonItems = [button1, button2, button3]
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fd_interactivePopDisabled = true
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
        VLog("http deinit")
    }
    fileprivate func requestOrigin(){
        SSRNetwork.shared.request(url: testApi, method: .get,  parameters: nil, headers: [:], success: { (response, dataResponse) in
            VLog(response)
        }) { (error) in
            VLog(error)
        }
    }
    fileprivate func requestYWMock(){
        SSRNetwork.shared.request( url: ywApi, method: .get, parameters: nil, headers: [:], success: { (response, dataResponse) in
            VLog(response)
        }) { (error) in
            VLog(error)
        }
    }
    fileprivate func requestFollowers(){
//        SSRGithubFollower().getMyFollowings { [weak self] (followings) in
//            self?.followers = followings
//            self?.tableView.reloadData()
//        }
        SSRGithubFollower().getMyFollowingsss().done { [weak self] (followers) in
            self?.followers = followers
            self?.tableView.reloadData()
        }
    }
    
    @objc func tappedButton(_ sender: UIButton?){
        // 1.
//        SSRGithubFollower().requestMyFollowings(success: { (data) in
//            if let data = data as? [SSRGithubFollower]{
//                self.followers = data
//                self.tableView.reloadData()
//            }
//        }) { error in
//            if let error = error{
//                print(error.localizedDescription)
//            }
//        }
//        // 2.
//        SSRGithubFollower().requestISFollowing("relatedcode", success: { (data) in
//
//        }) { (error) in
//            if let error = error{
//                print(error.localizedDescription)
//            }
//        }
//        SSRGithubRepository().searchRepository("SSR", success: { data in
//            let data = data as? SSRGithubRepositoryTotal
//            print(data?.total_count as Any)
//        }) { error in
//            if let error = error{
//                print(error.localizedDescription)
//            }
//        }
//        SSRGithubRepository().request(url: testApi, method: .get, parameter: nil, headers: nil, success: { (re) in
//            <#code#>
//        }, fail: <#T##(NSError?) -> Void#>)
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
