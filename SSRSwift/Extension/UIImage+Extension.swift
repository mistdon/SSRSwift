//
//  UIImage+Extension.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/18.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit

extension UIImage{
    // 颜色生成图片
    class func withColor(_ color: UIColor) -> UIImage?{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
