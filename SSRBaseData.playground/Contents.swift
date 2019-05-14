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


