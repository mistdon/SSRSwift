//
//  DesignPattern.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/5/19.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import Foundation

// 常用的设计模式,以及在Swift中的实践

/*============== 单例模式 ==============*/
//: 在程序运行期间只有有个实例，如：NotificationCenter, UserDefaults
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

/*============== 原型模式 ==============*/
