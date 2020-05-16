//
//  BaseTableView.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/5/15.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    fileprivate func commonInit(){
        separatorStyle = .none
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = true
        estimatedRowHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
        if #available(iOS 11.0, *){
          contentInsetAdjustmentBehavior = .never
          contentInset = .zero
          scrollIndicatorInsets = self.contentInset
        }
        contentInset = .zero
        // 解决tableview.style == .grouped时顶部留白
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0.01))
    }
    func bindTo(viewController: UIViewController) {
        if #available(iOS 11.0, *) {

        }else{
            viewController.automaticallyAdjustsScrollViewInsets = false
        }
        viewController.edgesForExtendedLayout = []
    }
    func scrollToFooterView(){
        let react = self.convert(self.tableFooterView?.bounds ?? .zero, from: self.tableFooterView)
        self.scrollRectToVisible(react, animated: true)
    }
    func easeScrollToFooterVIew(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
            if let react = self?.convert(self?.tableFooterView?.bounds ?? .zero, from: self?.tableFooterView){
                self?.scrollRectToVisible(react, animated: false)
            }
        }) { (finished) in
            
        }
    }
    func scrollToBottom(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
            if let sectionCount = self?.numberOfSections, let rowCount = self?.numberOfRows(inSection: sectionCount - 1), rowCount > 0{
                self?.scrollToRow(at: IndexPath(row: rowCount - 1, section: sectionCount - 1), at: .top, animated: false)
            }
        }
    }
    func scrollToTop(){
        self.setContentOffset(CGPoint.zero, animated: false)
    }
}
