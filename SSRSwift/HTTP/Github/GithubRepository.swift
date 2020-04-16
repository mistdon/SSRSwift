//
//  GithubRepository.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/9.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire

class SSRGithubRepository: HandyJSON {

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
extension SSRGithubRepository: SSRRequest{
   @discardableResult
   internal func request(url: URLConvertible, method: HTTPMethod, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest? {
       return nil
   }
}
