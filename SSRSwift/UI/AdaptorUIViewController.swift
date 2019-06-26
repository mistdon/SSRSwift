//
//  VNUIViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/26.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit

let textInset : UIEdgeInsets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)

class AdaptorUIViewController: BaseViewController {
    var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        testTextViewHeight()
    }
    func testTextViewHeight(){
        let text = "iPhone X 显示屏采用曲线优美的圆角设计，四个圆角位于一个标准矩形内。按照标准矩形测量时，屏幕的对角线长度是 5.85 英寸 (实际可视区域较小)。"
        //        let textContainer = NSTextContainer(size: CGSize(width: 100, height:CGFloat.greatestFiniteMagnitude))
        textView = UITextView(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        textView.backgroundColor = .green
        textView.delegate = self
//        textView.isEditable = false
//        textView.isSelectable = false
//        textView.isScrollEnabled = false
//        textView.isUserInteractionEnabled  = false
        view.addSubview(textView)
        print("screenWidth = \(App.screenWidth)")
        let attribute = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        textView.attributedText = attribute
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
//            //            let size = attribute.calculateSize(maxWith: 300)
//            let size = attribute.calculateSize(maxWith: 300, inset: self?.textView.textContainerInset ?? UIEdgeInsets.zero)
//            self?.textView.width = size.width
//            self?.textView.height = size.height
//            print("size.width = \(size.width), size.height = \(size.height)")
//        }
        print(textView.textContainerInset)
    }
    func calculateTextViewSize(){
        
    }
}
extension UIViewController: UITextViewDelegate{
    public func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
//        let widthText: CGFloat = textView.width
//        var heightText : CGFloat
//        let sizeText = textView.sizeThatFits(CGSize(width: widthText, height: CGFloat.greatestFiniteMagnitude))
//        heightText = CGFloat.maximum(30, sizeText.height)
//        heightText = CGFloat.minimum(110.0, heightText)
//        print("heightText = \(heightText)")
//        let heightInput: CGFloat = heightText + 44 - 30
//        print("heightInput = \(heightInput)")
//        textView.height = heightInput
        let maxwidth = App.screenWidth * 0.8 - textInset.left - textInset.right
        let rect = textView.text.boundingRect(with: CGSize(width: maxwidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)], context: nil)
        let width = rect.size.width + textInset.left + textInset.right
        let height = rect.size.height + textInset.top + textInset.bottom
        let size = CGSize(width: CGFloat.maximum(width, 50), height: CGFloat.maximum(height, 30))
        textView.width = size.width
        textView.height = size.height
        
    }
}
