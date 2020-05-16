//
//  GithubRepositoryResponse.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/5/14.
//  Copyright © 2019 shendong. All rights reserved.
//

import Foundation
import ObjectMapper

class GithubRepositoryResponse: Mappable{
    var items : [GithubRepository]?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        items <- map["items"]
    }
}

class GithubRepository: Mappable{
    var id : Double?
    var name : String?
    var owner : GithubRepositoryOwner?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        owner <- map["owner"]
    }
}

class GithubRepositoryOwner: Mappable {
    var login : String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        login <- map["login"]
    }
}
