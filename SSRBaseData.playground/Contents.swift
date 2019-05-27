import UIKit
import RxSwift
import RxCocoa

var str = "Hello, playground"

//public struct SectionModel<Section, ItemType>{
//    public var model: Section
//    public var items: [ItemType]
//    public init(model: Section, items: [ItemType]){
//        self.model = model
//        self.items = items
//    }
//}
////let queryStr = "SSRSwift://app/open?query={"url":"https://www.ifeng.com"}"
//let host = "SSRSwift://app/open?query="
//let queryKey = "url"
//let queryvalue = "https://www.baidu.com?query=123&cbid=hello"
//let map = [queryKey: queryvalue]
//
//let jsonData = try JSONSerialization.data(withJSONObject: map, options: .prettyPrinted)
////let decode   = try JSONSerialization.jsonObject(with: jsonData, options: [])
//
//let letters = queryvalue.addingPercentEncoding(withAllowedCharacters: .letters)
//let hostAllowed = queryvalue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//let queryAllowed = queryvalue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
var arr = [String]()
arr.append("a")
arr.append("a")
var sets = Set<String>()
sets.insert("a")
sets.insert("a")
print(sets)
var newsets: Set<String> = ["a", "b", "c"]
newsets.insert("b")
newsets.insert("b")

var names = [Int: String]()
names[14] = "six"
print(names[14]!)
names[14] = "sss"
