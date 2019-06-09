//
//  GithubRepository.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/9.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation
import HandyJSON

class SSRGithubRepository: HandyJSON, SSRRequest {
    var id : String?
    var name: String?
    var owner : SSRGithubFollower?
    required init() {
    }
    
}
class SSRGithubRepositoryTotal: HandyJSON{
    var total_count : Int = 0
    var incomplete_results = false
    var items : [SSRGithubRepository] = []
    required init() {
    }
}
extension SSRGithubRepository{
    func searchRepository(_ query: String, success: @escaping SuccessHandler, fail: @escaping FailHandler){
        self.request(url: SSRUrlPath.searchRepositories(), parameter: ["p": query as AnyObject], success: { (data) in
            if let data = data as? [String: Any]{
                let result = SSRGithubRepositoryTotal.deserialize(from: data)
                success(result)
            }
        }) { (error) in
            fail(error)
        }
    }
}
