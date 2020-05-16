//
//  SSRRxSwiftViewController.swift
//  SSRSwift
//
//  Created by shendong on 2019/5/10.
//  Copyright © 2019年 shendong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
// http://www.hangge.com/blog/cache/detail_1941.html
class SSRRxSwiftViewController: BaseViewController {
    var label = UILabel()
    var firstName = UITextField()
    var lastName  = UITextField()
    var button    = UIButton()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view!.backgroundColor = .gray
        print("Hai!")
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 44)
        firstName.frame = CGRect(x: 10, y: 200, width: 200, height: 44)
        firstName.placeholder = "fistname"
        lastName.frame = CGRect(x: 10, y: 250, width: 200, height: 44)
        lastName.placeholder = "lastname"
        button.frame = CGRect(x: 10, y: 300, width: 200, height: 44)
        button.backgroundColor = .red
        view.addSubview(label)
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(button)
        let firstnameValid = firstName.rx.text.orEmpty.map{$0.count > 5}
        .share(replay: 1)
        let lastnameValid  = lastName.rx.text.orEmpty.map{$0.count > 5}.share(replay: 1)
        Observable.combineLatest(firstnameValid, lastnameValid){$0 && $1}.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
    }
    deinit {
        print("deinit")
    }
}
