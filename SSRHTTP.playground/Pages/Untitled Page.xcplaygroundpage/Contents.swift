import UIKit
import Alamofire
import SwiftyJSON
public enum BaseUrl: String{
    case development = "https://api.github.com"
    case production = "https://testApi.github.com"
}

public enum API: String{
    case following = "/users/mistdon/following"
    case isFollowing = "/user/following/"
    static func testapi(){
        print(API.following.url())
        print(API.isFollowing.url())
    }
}
extension API{
    func url() -> String {
        return BaseUrl.development.rawValue + self.rawValue
    }
}
API.testapi()
