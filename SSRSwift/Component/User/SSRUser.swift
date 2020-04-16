//
//  SSRUser.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/31.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation
import HandyJSON
import PromiseKit

struct SSRUser: HandyJSON {
    
    var userId: String?
    
    var userKey: String?
    
    var name: String?
    
    var avator: String?
}

class SSRUserManager: NSObject {
    
    static let shared = SSRUserManager()
    
    var currentUser: SSRUser = SSRUser()
    
    private override init(){
        super.init()
        commonInit()
    }
    fileprivate func commonInit(){
        if let userInfo = SSRUserDefaults.objct(key: UD_CurrentUserInfo) as? [String: Any], let user = SSRUser.deserialize(from: userInfo){
            self.currentUser = user
        }
    }
    func isLogin() -> Bool{
        if let userId = self.currentUser.userId{
            return userId.count > 0
        }
        return false
    }
    func updateCurrentUser(user: SSRUser){
        self.currentUser = user
    }
    fileprivate func saveUserInfoToLocal(){
        if let jsonString = self.currentUser.toJSON(){
            SSRUserDefaults.setObject(value: jsonString, key: UD_CurrentUserInfo)
        }
    }
}
extension SSRUserManager{
    func login(userId: String?, userKey: String?) -> Promise<(Bool, Error?)> {
        return Promise { resolver in
            DispatchQueue.main.async {
                guard let id = userId, let key = userKey else{
                    return resolver.reject(NSError(domain: SSRAppModuleName, code: 2000, userInfo: nil))
                }
                if id == "ssr" && key == "123456"{
                    resolver.fulfill((true, nil))
                }else{
                    resolver.fulfill((false, NSError(domain: SSRAppModuleName, code: 20001, userInfo: [NSLocalizedDescriptionKey: "Wrong userId or key, Please try again!"])))
                }
            }
        }
    }
    func logOut(){
        SSRDataword.cleanCacheResponseObject()
        SSRDataword.shared.resetCookies()
    }
}
