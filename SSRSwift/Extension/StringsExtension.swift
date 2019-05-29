//
//  StringsExtension.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/29.
//  Copyright © 2019 shendong. All rights reserved.
//

import Foundation
/*
 检查String是否是Empty,
    - 如果只是定义 nil、"" 为空的话，直接用isEmpty;
    - 如果同时定义" "、"\t\r\n" 、 "\u{00a0}" 、 "\u{2002}" 、 "\u{2003}"等的话，可以用下面的isBlank
 参考链接: https://useyourloaf.com/blog/empty-strings-in-swift/
 */
extension String{
    var isBlank: Bool{
        return allSatisfy({$0.isWhitespace})
    }
}
extension Optional where Wrapped == String{
    var isBlank : Bool{
        return self?.isBlank ?? true
    }
}
