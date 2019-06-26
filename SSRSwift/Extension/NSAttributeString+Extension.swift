//
//  NSAttributeString+Extension.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/26.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit

extension NSAttributedString{
    func calculateSize(maxWith: CGFloat) -> CGSize{
        let constrainRect = CGSize(width: maxWith, height: CGFloat.zero)
        let boundingBox = self.boundingRect(with: constrainRect, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], context: nil)
        return CGSize(width: boundingBox.width, height: ceil(boundingBox.height))
    }
    func calculateSize(maxWith: CGFloat, inset: UIEdgeInsets) -> CGSize{
        let constrainRect = CGSize(width: maxWith, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constrainRect, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], context: nil)
        return CGSize(width: ceil(boundingBox.width), height: ceil(boundingBox.height + inset.top + inset.bottom))
    }
}
