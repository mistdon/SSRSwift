//
//  SSRDataword.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/8.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation

class SSRDataword {
    static let shared = SSRDataword()
    private init() {
        commonInit()
    }
    private func commonInit(){
        let debugStatus =  SSRUserDefaults.objct(key: UD_DebugModel)
        if let status = debugStatus{
            self.debugModel = status as! Bool
        }else{
            #if DEBUG
                self.debugModel = true
            #else
                self.debugModel = false
            #endif
        }
    }
    var debugModel: Bool = false{
        willSet{
            SSRUserDefaults.setObject(value: newValue, key: UD_DebugModel)
        }
    }
    func resetCookies(){
        let userId = SSRUserManager.shared.currentUser.userId ?? "0"
        let channle = App.channel
        let domains = [".shendong.store", ".shendong.store"]
        let keys = ["useId", "channel"]
        let values = [userId, channle]
        for domain in domains{
            for k in 0..<keys.count{
                var properties = [HTTPCookiePropertyKey: Any]()
                properties[.value] = values[k] as Any
                properties[.name]  = keys[k] as Any
                properties[.domain] = domain as Any
                properties[.expires] = Date(timeIntervalSinceNow: 60*60*24*30) as Any
                properties[.path] = "/" as Any
                let cookie = HTTPCookie(properties: properties)
                if let cookie = cookie{
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
        }
    }
    static func cleanCacheResponseObject(){
        URLCache.shared.removeAllCachedResponses()
        let storage : HTTPCookieStorage = HTTPCookieStorage.shared
        if let cookies = storage.cookies{
            for cookie in cookies{
                storage.deleteCookie(cookie)
            }
        }
    }
}
