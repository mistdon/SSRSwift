//
//  SSRViewControllerProtocol.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/10.
//  Copyright © 2019年 shendong. All rights reserved.
//

import Foundation
import UIKit

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
