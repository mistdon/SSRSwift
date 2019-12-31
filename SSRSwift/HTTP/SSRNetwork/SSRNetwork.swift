//
//  SSRNetWork.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/13.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import Alamofire

typealias SSSNetworkSuccess = (_ data: SSRResponse?, _ dataResponse: DataResponse<Any>?) -> Void

typealias SSRNetworkFailure = (_ error: NSError?) -> Void

public class SSRNetwork{
    
    static let shared = SSRNetwork()
    
    private var alamofireManager: Alamofire.SessionManager?
    
    private init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    func requestData(method: Alamofire.HTTPMethod,
                             url: String,
                             parameters: [String: AnyObject]?,
                             headers: [String: String],
                             success: @escaping SSSNetworkSuccess,
                             fail: @escaping SSRNetworkFailure) -> DataRequest?
                             {
        let request = alamofireManager?.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        request?.responseJSON(completionHandler: { response in
            switch response.result{
            case .success:
                success(response.result.value as! SSRResponse, response)
            case .failure:
                fail(response.error as NSError?)
            }
        })
       return request
    }
    func get(url: String, parameters: [String: AnyObject]?, headers: [String: String], success: @escaping SSSNetworkSuccess, failure: @escaping SSRNetworkFailure){
        
    }
}
private extension SSRNetwork{
    private func parseResponse(value: Any?){
//        if let response = 
    }
}
