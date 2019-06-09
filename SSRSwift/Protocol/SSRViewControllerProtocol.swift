//
//  SSRViewControllerProtocol.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/10.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import UIKit

/*

 protocl 协议
 1. protocol 可以有默认实现，通过在extenison中实现默认实现
 2. OC中协议的方法可以通过optional标记为可选，swift中如何实现可选协议呢？
    方法1: 如果是混用的Protocol，可以通过添加 @objc @optional来实现，
     ```swift
     @objc protocol MyProtocol {
     @objc optional func anOptionalMethod()
    }
     ```
    方法1: 协议只在Swift中使用，可以在extenison中实现默认实现，表示为这个value或者func是optional的
 
*/


protocol SSRViewControllBaseProtocol {
    func setBaseViewControllerConfiguration()
}
//extension UIViewController: SSRViewControllBaseProtocol{
//    func setBaseViewControllerConfiguration() {
//        view.backgroundColor = .white
//    }
//}

extension SSRViewControllBaseProtocol where Self: UIViewController{
    
}

// 参考链接：https://medium.com/@ant_one/how-to-have-optional-methods-in-protocol-in-pure-swift-without-using-objc-53151cddf4ce
