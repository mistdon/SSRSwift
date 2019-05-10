import UIKit
import RxSwift
import RxCocoa
var str = "Hello, playground"
// 创建Obervable序列
//let observable = Observable<Int>.just(5)
//let observable2 = Observable.of("A", "B", "C")
//let observable3 = Observable<String>.create {observer in
//    observer.onNext("ssr")
//    observer.onCompleted()
//    return Disposables.create()
//}
//observable3.subscribe{
//  print($0)
//}
//var isOdd = true
//let factory: Observable<Int> = Observable.deferred {
//    isOdd.toggle()
//    if isOdd{
//        return Observable.of(1, 3, 5, 7)
//    }else{
//        return Observable.of(2, 4, 6, 8)
//    }
//}
//factory.subscribe { event in
//    print("\(isOdd)", event)
//}
//factory.subscribe { event in
//    print("\(isOdd)", event)
//}
//let observable4 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//observable4.subscribe { event in
//    print(event)
//}
//print("Now")
//let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
//observable.subscribe { event in
//    print(event)
//}
let observable = Observable.of("A", "B", "C")
observable.subscribe(onNext: { (element) in
    print(element)
}, onError: { (error) in
    print(error)
}, onCompleted: {
    print("completed")
}) {
    print("disposed")
}
