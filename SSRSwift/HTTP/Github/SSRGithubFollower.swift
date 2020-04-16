//
//  SSRGithubFollower.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/5.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire
import PromiseKit

class SSRGithubFollower: HandyJSON {
    required init() {}
    var login : String?
    var id : Double?
    var avatar_url: String?
    var url: String?
}
extension SSRGithubFollower: SSRRequest{
    func getMyFollowings(result : @escaping ([SSRGithubFollower]) -> Void){
        self.request(url: "https://api.github.com/users/mistdon/following", method: .get, parameter: nil, success: { (response) in
            guard response.code == 0, let data = response.data as? [Any], let followings = [SSRGithubFollower].deserialize(from: data) else{
                Toast(text: response.message, type: 2).show()
                return
            }
            result(followings.compactMap({$0}))
        }) { (error) in
            VLog(error?.localizedDescription)
        }
    }
    func getMyFollowingsss() -> Promise<[SSRGithubFollower]>{
        return Promise { (resovler) in
            self.request(url: "https://api.github.com/users/mistdon/following", method: .get, parameter: nil, success: { (response) in
                guard response.code == 0, let data = response.data as? [Any], let followings = [SSRGithubFollower].deserialize(from: data) else{
                    resovler.reject(NSError(domain: "ssr", code: 10002, userInfo: nil))
                    return
                }
                resovler.fulfill(followings.compactMap({ $0 }))
            }) { (error) in
                VLog(error?.localizedDescription)
                resovler.reject(NSError(domain: "ssr", code: 10003, userInfo: nil))
            }
        }
    }
}
