//
//  SSRUserDefaults.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/8.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation

private let UDPrefix = "com.ssrswift."

let UD_WKUserAgent     = UDPrefix + "wkWebView.userAgent"
let UD_CurrentUserInfo = UDPrefix + "currentUserInfo"
let UD_DebugModel      = UDPrefix + "debugModel"

class SSRUserDefaults: NSObject {
    class func setObject(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func removeObject(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func removeObject(key: String, delay: TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            removeObject(key: key)
        }
    }
    class func objct(key: String) -> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    class func string(key: String) -> String?{
        return UserDefaults.standard.string(forKey: key)
    }
    class func integer(key: String) -> Int{
        return UserDefaults.standard.integer(forKey: key)
    }
    class func bool(key: String) -> Bool{
        return UserDefaults.standard.bool(forKey: key)
    }
}
