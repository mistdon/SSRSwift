//
//  SSRRouter.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/29.
//  Copyright © 2019 shendong. All rights reserved.
//

import UIKit
// MARK: SSRRouterActionType
@objc public enum SSRRouterActionType: Int {
    case none = -1, push, present, model, modelNavigator
}
// MARK: SSRRouterAction
@objc public class SSRRouterAction: NSObject{
    @objc public class func routerAction(fromViewController: UIViewController, toViewController: UIViewController, type: SSRRouterActionType){
    }
}
// MARK: SSRRouter
@objc public class SSRRouter: NSObject {
    @objc public class func open(url: URL) -> Bool{
        return true
    }
    @objc public class func open(url: URL, fromVC: UIViewController, action: String) -> Bool{
        return true
    }
}
