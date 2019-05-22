import UIKit
import RxSwift
import RxCocoa

var str = "Hello, playground"

public struct SectionModel<Section, ItemType>{
    public var model: Section
    public var items: [ItemType]
    public init(model: Section, items: [ItemType]){
        self.model = model
        self.items = items
    }
}
//let queryStr = "SSRSwift://app/open?query={"url":"https://www.ifeng.com"}"
let host = "SSRSwift://app/open?query="
let queryKey = "url"
let queryvalue = "https://www.baidu.com?query=123&cbid=hello"
let map = [queryKey: queryvalue]

let jsonData = try JSONSerialization.data(withJSONObject: map, options: .prettyPrinted)
//let decode   = try JSONSerialization.jsonObject(with: jsonData, options: [])

let letters = queryvalue.addingPercentEncoding(withAllowedCharacters: .letters)
let hostAllowed = queryvalue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
let queryAllowed = queryvalue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)


