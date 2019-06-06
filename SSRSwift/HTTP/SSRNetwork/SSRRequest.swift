//
//  SSRRequest.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/5.
//  Copyright © 2019 shendong. All rights reserved.
//

import Foundation
import Alamofire

protocol SSRRequest {

    typealias SuccessHandler = (_ data: Any?) -> Void

    typealias FailHandler = (_ error: Error?) -> Void

    var url: String {get}

    var method: Alamofire.HTTPMethod {get}

    var parameters : [String: AnyObject]? {get}

    var headers : [String: String] {get}

    func map(value: Any) -> AnyObject

    func request(success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?

}
extension SSRRequest {
    var headers : [String: String]{
        return self.getRequestHeaders()
    }
//    @discardableResult
//    func request(success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
//        return SSRNetwork.shared.requestData(method: method, url: url, parameters: parameters, headers: headers, success: success, fail: fail)
//    }
}
extension SSRRequest {
    func getRequestHeaders() -> [String: String]{
        let headersParams : [String: String] = [
            "platform":"iOS",
            "model":"iPhone"
        ]
        return headersParams
    }
}
