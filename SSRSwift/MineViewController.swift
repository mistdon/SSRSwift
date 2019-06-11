//
//  MineViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/11.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MineViewController: UIViewController {
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.setTitle("Push Next", for: .normal)
        button.rx.tap.subscribe(onNext: { [weak self] in
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            self?.navigationController?.show(vc, sender: nil)
        }).disposed(by: disposeBag)
        view.addSubview(button)
        button.snp.makeConstraints { [weak self] (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(self!.view)
        }
    }
}
