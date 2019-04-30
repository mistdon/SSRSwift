import UIKit
import SwiftyJSON

var str = "Hello, playground"
print(str)

let messageDict: [String: Any] = ["code":0, "message":"success"]
let jsonData = try JSONSerialization.data(withJSONObject: messageDict, options: .prettyPrinted)
let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)
print(jsonString as? String)

let json = try? JSON(data: jsonData)
print(json?["message"].stringValue)
