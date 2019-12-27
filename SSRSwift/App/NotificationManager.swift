//
//  NotificationManager.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/27.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation

// 这里作为自定义通知的统一管理类

extension Notification.Name{
    /// 登录成功
    static let didLogin  = Notification.Name("didLogin")
    /// 退出登录
    static let didLogOut = Notification.Name("didLogOut")
    
}
