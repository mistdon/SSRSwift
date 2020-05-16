//
//  Singleton.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/3.
//  Copyright © 2019 shendong. All rights reserved.
//

import Foundation

/*
 单例模式
 */

// 单例Class
class SingletonClass{
    static let shared = SingletonClass()
    private init(){}
}
// 单例Struct
struct SingletonStruct {
    static let sharedInstance = SingletonStruct()
    private init(){}
}
