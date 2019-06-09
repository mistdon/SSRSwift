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

    var headers : [String: String] {get}
    
    func request(url: String, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?

    func request(url: String, parameter: [String: AnyObject]?, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?
}
extension SSRRequest {
    var headers : [String: String]{
        return self.getRequestHeaders()
    }
    @discardableResult
    func request(url: String, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
        return request(url: url, parameter: nil, success: success, fail: fail)
    }
    @discardableResult
    func request(url: String, parameter: [String: AnyObject]?, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
        let success:((Any?, DataResponse<Any>?) -> Void) = {(_, response) -> Void in
            if let value = response?.result.value{
                success(value)
            }
        }
        return SSRNetwork.shared.requestData(method: .get, url: url, parameters: parameter, headers: [:], success: success, fail: fail)!
    }
}
extension SSRRequest {
    func getRequestHeaders() -> [String: String]{
        let headersParams : [String: String] = [
            "platform":"iOS",
            "model":"iPhone"
        ]
        return headersParams
    }
    
    /// 添加额外参数，比如签名信息，或者对参数加密等操作
    ///
    /// - Parameter parameters: 原始参数
    /// - Returns: 返回的参数
    func addParametersAdtional(parameters: [String: AnyObject]?) -> [String: AnyObject]? {
        if var parames = parameters{
            parames.updateValue("test value" as AnyObject, forKey: "test")
            return parames
        }
        return [:]
    }
}
