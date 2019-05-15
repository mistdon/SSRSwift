//
//  SSRGithubFollower.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import HandyJSON

class SSRGithubFollower: HandyJSON {
    required init() {
        
    }
    var login : String?
    var id : Double?
    var avatar_url: String?
    var url: String?
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else{return}
        login = (dictionary["login"] as? String)!
        id    = dictionary["id"] as? Double
        avatar_url = dictionary["avatar_url"] as? String
        url   = dictionary["url"] as? String
    }
}
