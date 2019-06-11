//
//  TabBarController.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/11.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit
import RTRootNavigationController

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNavi = RTContainerNavigationController(rootViewController: SSRRootTableViewController())
        homeNavi.tabBarItem = UITabBarItem(title: "首页", image: nil, selectedImage: nil)
        let mineNavi = RTContainerNavigationController(rootViewController: MineViewController())
        mineNavi.tabBarItem = UITabBarItem(title: "我的", image: nil, selectedImage: nil)
        self.viewControllers = [homeNavi, mineNavi]
    }
}
