//
//  SSRLoginViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/31.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit

class SSRLoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Login"
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(hex6: "#62CCB0")
        button.setTitle("Login", for: .normal)
        button.rx.tap.subscribe(onNext: {
            if SSRUserManager.shared.isLogin(){
                Toast(text: "已登录").show()
                return
            }
            SSRUserManager.shared.login(userId: "ssr", userKey: "123236").done { (arg) in
                let (result, error) = arg
                if result == true{
                    Toast(text: "登录成功", type: 1).show()
                }else{
                    if let nserror = error as NSError?{
                        Toast(text: nserror.localizedDescription, type: 1).show()
                    }
                }
            }.catch { error in
                VLog(error)
            }
        }).disposed(by: base_disposeBag)
        view.addSubview(button)
        button.snp.makeConstraints { [weak self] (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(self!.view)
        }
        
        let logOutButton = UIButton(type: .custom)
        logOutButton.backgroundColor = UIColor(hex6: "#62CCB0")
        logOutButton.setTitle("LogOut", for: .normal)
        logOutButton.rx.tap.subscribe(onNext: { [weak self] in
            SSRUserManager.shared.logOut()
            Toast(text: "Logout Success").show()
            UIApplication.shared.openURL(URL(string: "https://app.huamengxiaoshuo.com/vnovel/test/")!)
        }).disposed(by: base_disposeBag)
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { [weak self] (make) -> Void in
            make.top.equalTo(button.snp_bottom).offset(100.0)
            make.width.height.equalTo(100)
            make.centerX.equalTo(self!.view)
        }
    }
}
