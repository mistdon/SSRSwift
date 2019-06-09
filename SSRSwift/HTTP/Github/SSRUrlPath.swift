//
//  SSRUrlPath.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/9.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation
/*
 let API_URL = "https://api.github.com/search/repositories?q=ss"
 
 let testApi = "https://api.github.com/users/mistdon/following"
 */



struct SSRUrlPath {
    // 查看我关注的人员列表
    static func following() -> String {
        return BaseUrl.production.rawValue + "/users/mistdon/following"
    }
    // 查看我是否关注releatedCode；关注返回204;没有关注返回404
    static func isFollowing(username: String) -> String{
        return BaseUrl.production.rawValue + "/user/following/\(username)"
    }
    // 关注某人，成功返回204；PUT请求
    static func putToFollow(username: String) -> String{
        return BaseUrl.production.rawValue + "/user/following/\(username)"
    }
    // 取消关注某人，成功返回204；DELETE请求
    static func deleteToUnfollow(username: String) -> String{
        return BaseUrl.production.rawValue + "/user/following/\(username)"
    }
    static func searchRepositories() -> String {
        return BaseUrl.production.rawValue + "/search/repositories"
    }
}
