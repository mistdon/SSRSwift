//
//  SSRResponse.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/9.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation
import HandyJSON

struct SSRResponse: HandyJSON {
    var code: Int = 0
    var message : String?
    var data: Any?
}
struct SSRResponseError {
    var id: String?
    var code: String?
    var message: String?
}
enum SSRErrorCode: String{
    case OK = "0"
    case Fail = "1"
    
}
