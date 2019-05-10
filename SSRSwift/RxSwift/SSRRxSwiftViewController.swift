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
class SSRRxSwiftViewController: UIViewController {
    var label = UILabel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view!.backgroundColor = .white
        print("Hi!")
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 44)
        view.addSubview(label)
        
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event{
            case .next(let data):
                print(data)
                self.label.text = data
            case .error(let error):
                print(error)
            case .completed:
                print("completed.")
            }
        }
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map {"current Index : \($0)"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    deinit {
        print("deinit")
    }
}
