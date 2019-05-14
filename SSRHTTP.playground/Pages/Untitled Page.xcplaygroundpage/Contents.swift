import UIKit
import Alamofire
import SwiftyJSON

var str = "Hello, playground"

let testApi = "https://api.github.com/users/mistdon/following"

let searchApi = "https://api.github.com/search/repositories?q=ss"

Alamofire.request(searchApi).responseJSON {dataResponse in
    print(dataResponse)
}
