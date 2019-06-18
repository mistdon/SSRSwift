//
//  UIColor+Extension.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/6.
//  Copyright © 2019 shendong. All rights reserved.
//
//  https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-html-name-string-into-a-uicolor

import UIKit

extension UIColor{
    /// 16进制Hex转换成Color
    /// - Demo:
    ///   let color = UIColor.colorWithHex(rgb: 0x1A1B1C, alpha: 1)
    /// - Parameters:
    ///   - rgb: 16进制色值
    ///   - alpha: 透明度
    /// - Returns: Color
    public class func hexWith(rgb: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16))/255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 16))/255.0,
                       blue: ((CGFloat)((rgb & 0xFF) >> 16))/255.0,
                       alpha: alpha)
    }
    
    /// 8位htmlString转换成Color
    /// - Demo:
    ///   let color = UIColor(hex8: "#F0F8FFFF")
    ///
    /// - Parameter hex: hex description
    public convenience init?(hex8: String){
        let r, g, b, a: CGFloat
        if hex8.hasPrefix("#"){
            let start = hex8.index(hex8.startIndex, offsetBy: 1)
            let hexColor = String(hex8[start...])
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber){
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    /// 6位htmlString转换成Color
    /// - Demo:
    ///   let color = UIColor(hex6: "#62CCB0 0.5")
    ///   let color = UIColor(hex6: "#62CCB0")
    ///
    /// - Parameter hex: hex description
    public convenience init?(hex6: String){
        let r, g, b: CGFloat
        var a: CGFloat
        if hex6.hasPrefix("#"){
            let start = hex6.index(hex6.startIndex, offsetBy: 1)
            var hexColor = String(hex6[start...])
            let hexArray = hexColor.components(separatedBy: " ")
            a = 1.0
            if hexArray.count == 2{
                hexColor = hexArray[0]
                let temp_alpha = Double(hexArray[1])
                if let temp_alpha = temp_alpha, temp_alpha >= 0, temp_alpha <= 1.0 {
                    a = CGFloat(temp_alpha)
                }
            }
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber){
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
