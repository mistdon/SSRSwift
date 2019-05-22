//
//  ColorExtension.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/22.
//  Copyright © 2019 shendong. All rights reserved.
//

import UIKit

extension UIColor{
    /// 16进制Hex转换成Color
    /// - Demo:
    ///   let color = UIColor.colorWithHex(rgb: 0x1A1B1C, alpha: 1)
    /// - Parameters:
    ///   - rgb: 16进制色值
    ///   - alpha: 透明度
    /// - Returns: Color
    public class func colorWithHex(rgb: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgb & 0xFF00) >> 16))/255.0, blue: ((CGFloat)((rgb & 0xFF) >> 16))/255.0, alpha: alpha)
    }
}
