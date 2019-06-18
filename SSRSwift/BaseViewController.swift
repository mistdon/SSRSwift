//
//  BaseViewController.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/11.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit
import SVGKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    
    var base_disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        edgesForExtendedLayout = [] // 这里设置将View的起始位置在导航栏下面
        
        // Set NavigationBar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16.0),
                                                                        NSAttributedString.Key.foregroundColor:UIColor(hex8: "#1A1B1C") ?? UIColor.black]
    
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        if (self.navigationController?.viewControllers.count)! > 0 {
            setLeftBackButton { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    fileprivate func loadNavigationBar(){
        guard self.navigationItem.leftBarButtonItem != nil else {
            return
        }
        let closeButton = UIButton.init(type: .custom)
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        closeButton.setImage(SVGKImage.init(named: "navi_back.svg")?.uiImage, for: .normal)
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            if let navigationController = self?.navigationController {
                if navigationController.viewControllers.count > 1{
                    navigationController.popViewController(animated: true)
                }
            }else{
                self?.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: base_disposeBag)
        let closeItem = UIBarButtonItem.init(customView: closeButton)
        self.navigationItem.leftBarButtonItems = [createLeftNegativeSpacerItem(), closeItem]
    }
    fileprivate func setLeftBackButton(closure: @escaping () -> Void){
        let closeButton = UIButton.init(type: .custom)
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        closeButton.setImage(SVGKImage.init(named: "navi_back.svg")?.uiImage, for: .normal)
        closeButton.rx.tap.subscribe(onNext: {
            closure()
        }).disposed(by: base_disposeBag)
        let closeItem = UIBarButtonItem.init(customView: closeButton)
        self.navigationItem.leftBarButtonItems = [createLeftNegativeSpacerItem(), closeItem]
    }
    fileprivate func createLeftNegativeSpacerItem() -> UIBarButtonItem{
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacerItem.width = -80
        return spacerItem
    }
    fileprivate func createRightNegativeSpacerItem() -> UIBarButtonItem{
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacerItem.width = 40
        return spacerItem
    }
}
