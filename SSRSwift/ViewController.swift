//
//  ViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/4/30.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let testApi = "https://api.github.com/users/mistdon/following"
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(testApi).response { response in
            print(response)
        }
    }
}
