//
//  Appearance.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/18.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit
import SVGKit

class Appearance {
    // 统一设置所有导航栏
    class func configureNavigationBarAppearance() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(hex6: "#62CCB0 0.5")
        navigationBarAppearace.barTintColor = UIColor(hex6: "#62CCB0")
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
    }
}
