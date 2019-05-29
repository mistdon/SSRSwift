//
//  SSRRouterViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/29.
//  Copyright © 2019 shendong. All rights reserved.
//

import UIKit

protocol SSRRouteOpenCustomURLSchemeProtocl {
    static func openCustomeURLScheme(_ customURLScheme: String)
}

class SSRRouterViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SSRRouterViewController: SSRRouteOpenCustomURLSchemeProtocl{
    static func openCustomeURLScheme(_ customURLScheme: String) {
        if canOpenURL(customURLScheme) {
            // app was opened successfully
        }else{
            // app was opened failed, then next...
        }
    }
    fileprivate static func canOpenURL(_ urlString: String) -> Bool{
        let customURL = URL(string: urlString)
        guard let url = customURL else { return false }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.canOpenURL(url)
            }
            return true
        }
        return false
    }
}
