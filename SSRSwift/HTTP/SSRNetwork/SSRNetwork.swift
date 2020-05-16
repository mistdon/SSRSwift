//
//  SSRNetWork.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/13.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

private let SSRNetworkDomain = "domain.SSRNetwork"

typealias SSSNetworkSuccess = (_ response: SSRResponse, _ dataResponse: DataResponse<Any>?) -> Void

typealias SSRNetworkFailure = (_ error: NSError?) -> Void
/// Default timeout Interval (默认超时时间)
public var SSRNetworkDefaultTimeOut : TimeInterval = 60

public class SSRNetwork{
    static let shared = SSRNetwork()

    private var alamofireManager: Alamofire.SessionManager?
    /// temp session manager, used for change default timeout intervale
    private var tempSessionManager: Alamofire.SessionManager?
    var customHeaders: [String: String] = ["Accept": "application/json"]
    private init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest   = SSRNetworkDefaultTimeOut
        configuration.timeoutIntervalForResource  = SSRNetworkDefaultTimeOut
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    class func configur(timeoutInterval: TimeInterval){
        SSRNetworkDefaultTimeOut = timeoutInterval
    }
    @discardableResult
    func request(url: URLConvertible,
                 method: Alamofire.HTTPMethod,
                 parameters: [String: AnyObject]?,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: [String: String]?,
                 timeoutInterval: TimeInterval = SSRNetworkDefaultTimeOut,
                 success: @escaping SSSNetworkSuccess,
                 fail: @escaping SSRNetworkFailure) -> DataRequest?{
        let request = requestOrigin(url: url, method: method, parameters: parameters, encoding: encoding, headers: headers, timeoutInterval: timeoutInterval, success: { (response, dataResponse) in
            guard let dataResponse = dataResponse else{
                return
            }
            switch dataResponse.result{
            case .success:
                guard let datas : [String: AnyObject] = dataResponse.result.value as? [String: AnyObject] else{
                    success(SSRResponse(code: 0, message: "Handle data by yourself", data: dataResponse.result.value), dataResponse)
                    return
                }
                if let code = datas["code"]?.int8Value, let message = datas["message"] as? String{
                    if code == 0 {
                        let tempResponse = SSRResponse(code: Int(code), message: message, data: datas["data"] )
                        success(tempResponse, dataResponse)
                    }else{
                        fail(NSError(domain: SSRNetworkDomain, code: Int(code), userInfo: [NSLocalizedDescriptionKey: message]))
                    }
                }else{
                    success(SSRResponse(code: 0, message: "Handle data by yourself", data: datas), dataResponse)
                }
            case .failure:
                fail(dataResponse.error as NSError?)
            }
        }) { (error) in
            fail(error as NSError?)
        }
        return request
    }
    @discardableResult
    func requestOrigin(url: URLConvertible,
                       method: Alamofire.HTTPMethod,
                       parameters: [String: AnyObject]?,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: [String: String]?,
                       timeoutInterval: TimeInterval = SSRNetworkDefaultTimeOut,
                       success: @escaping SSSNetworkSuccess,
                       fail: @escaping SSRNetworkFailure) -> DataRequest?{
        var resHeaders = self.customHeaders
        if let headers = headers, headers.count > 0{
            for dict in headers{
                resHeaders[dict.key] = dict.value
            }
        }
        var currentSessionManager:Alamofire.SessionManager?
        if (timeoutInterval != SSRNetworkDefaultTimeOut){
             let configuration = URLSessionConfiguration.default
             configuration.timeoutIntervalForRequest = timeoutInterval
             configuration.timeoutIntervalForResource = timeoutInterval
             configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
             tempSessionManager = Alamofire.SessionManager(configuration: configuration)
             currentSessionManager = tempSessionManager
        }else{
             currentSessionManager = self.alamofireManager
        }
        let request = currentSessionManager?.request(url, method: method, parameters: parameters, encoding: encoding, headers: resHeaders)
        request?.responseJSON(completionHandler: { (dataResponse) in
            switch dataResponse.result{
            case .success:
                success(SSRResponse(code: 0, message: "Handle data by yourself.", data: nil), dataResponse)
            case .failure:
                fail(dataResponse.error as NSError?)
            }
        })
        return request
    }
    @discardableResult
    func get(url: URLConvertible,
             parameters: [String: AnyObject]?,
             headers: [String: String]?,
             timeoutInterval: TimeInterval = SSRNetworkDefaultTimeOut,
             success: @escaping SSSNetworkSuccess,
             fail: @escaping SSRNetworkFailure) -> DataRequest?{
        return request(url: url, method: .get, parameters: parameters, headers: headers, success: success, fail: fail)
    }
    @discardableResult
    func post(url: URLConvertible,
              parameters: [String: AnyObject]?,
              headers: [String: String]?,
              timeoutInterval: TimeInterval = SSRNetworkDefaultTimeOut,
              success: @escaping SSSNetworkSuccess,
              fail: @escaping SSRNetworkFailure) -> DataRequest?{
       return request(url: url, method: .post, parameters: parameters, headers: headers, success: success, fail: fail)
   }
}
