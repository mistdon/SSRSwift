//
//  SSRGithubFollower.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import HandyJSON

class SSRGithubFollower: HandyJSON, SSRRequest {
    
    required init() {
        
    }
    var login : String?
    var id : Double?
    var avatar_url: String?
    var url: String?

}
extension SSRGithubFollower{
    func requestMyFollowings(success: @escaping SuccessHandler, fail: @escaping FailHandler){
        self.request(url: SSRUrlPath.following(), parameter: nil, success: { data in
            if let data = data as? [[String: Any]]{
                let resultArray = [SSRGithubFollower].deserialize(from: data)
                success(resultArray)
            }
        }) { error in
            fail(error)
        }
    }
    func requestISFollowing(_ name: String, success: @escaping SuccessHandler, fail: @escaping FailHandler) {
        self.request(url: SSRUrlPath.isFollowing(username: name), success: { (data) in
            success(data)
        }) { (error) in
            fail(error)
        }
    }
}

