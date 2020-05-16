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

    typealias SuccessHandler = (_ data: SSRResponse) -> Void

    typealias FailHandler = (_ error: NSError?) -> Void
    func request(url: URLConvertible, method: Alamofire.HTTPMethod, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?

    func request(url: URLConvertible, method: Alamofire.HTTPMethod, parameter: [String: AnyObject]?, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?
    func request(url: URLConvertible, method: Alamofire.HTTPMethod, parameter: [String: AnyObject]?, headers: [String: String]?, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?
}
extension SSRRequest {
    func request(url: URLConvertible, method: Alamofire.HTTPMethod, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
        return request(url: url, method: method, parameter: nil, success: success, fail: fail)
    }
    @discardableResult
    func request(url: URLConvertible, method: Alamofire.HTTPMethod = .get, parameter: [String: AnyObject]?, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
        return request(url: url, method: method, parameter: parameter, headers: nil, success: success, fail: fail)
    }
    @discardableResult
    func request(url: URLConvertible, method: Alamofire.HTTPMethod = .get, parameter: [String: AnyObject]?, headers: [String: String]? = nil, success: @escaping SuccessHandler, fail: @escaping FailHandler) -> DataRequest?{
        SSRNetwork.shared.request(url: url, method: method, parameters: parameter, headers: headers, success: { (response, dataResponse) in
            success(response)
        }) { (error) in
            fail(error)
        }
    }
}
