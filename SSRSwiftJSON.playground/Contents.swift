import UIKit
import SwiftyJSON

var str = "Hello, playground"

let json = JSON(["name":"Jack", "age":25])
if let name = json["address"].string{
    print(name)
}else{
    print(json["address"].error!)
}
