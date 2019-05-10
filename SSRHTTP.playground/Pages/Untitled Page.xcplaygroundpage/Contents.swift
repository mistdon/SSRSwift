import UIKit
import Alamofire
import SwiftyJSON

var str = "Hello, playground"

let testApi = "https://api.github.com/users/mistdon/following"

Alamofire.request(testApi).responseJSON {dataResponse in
    if let data = dataResponse.data {
        let json = try? JSON(data: data)
//        print(json)
        for dict in json?.arrayObject?{
            print(dict)
        }
    }
    
}
