//
//  UIControl+Extension.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/5/15.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import UIKit

class ClosureSleeve {
    let closure: () -> ()
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    @objc func invoke() {
        closure()
    }
}
extension UIControl{
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}
