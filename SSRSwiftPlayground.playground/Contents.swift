import UIKit
import SwiftyJSON

var str = "Hello, playground"
print(str)

struct SSRMessage{
    var code: Int?
    var message: String?
    public init(dict: [String: Any]){
        code = dict["code"] as? Int
        message = dict["message"] as? String
    }
}

let messageDict: [String: Any] = ["code":404, "message":"success"]

let json = JSON(messageDict)
print(json)

let msg = SSRMessage(dict: messageDict)

print(msg.message as Any)


let name = ""
if name.count == 0{
    print("You're anonymous")
}
if name.isEmpty{
    print("You're anonymous")
}
