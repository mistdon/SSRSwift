//
//  TabBarController.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/11.
//  Copyright © 2019 Don.shen. All rights reserved.
//

/*
TabBarController 相关
 
 
*/




import UIKit
import RTRootNavigationController

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        let homeNavi = RTContainerNavigationController(rootViewController: SSRRootTableViewController())
        homeNavi.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        let mineNavi = RTContainerNavigationController(rootViewController: MineViewController())
        mineNavi.tabBarItem = UITabBarItem(title: "Mine", image: nil, selectedImage: nil)
        let customNavi = RTContainerNavigationController(rootViewController: CustomNaviBarController())
        customNavi.tabBarItem = UITabBarItem(title: "Navi", image: nil, selectedImage: nil)
        self.viewControllers = [homeNavi, mineNavi, customNavi]
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏TabBarController的导航栏，各导航栏由各自控制
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
extension TabBarController{
    
}
