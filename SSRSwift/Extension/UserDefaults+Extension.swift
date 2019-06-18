//
//  UserDefaults.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/12.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation

extension UserDefaults{
    enum Keys {
        static let schedule = "schdule"
        static let debugModel = "debugModel"
    }
}

class TestUserDefaultsExtension {
    func test() {
       _ = UserDefaults.Keys.schedule
    }
}
