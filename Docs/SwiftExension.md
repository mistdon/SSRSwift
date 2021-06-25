### Extension的使用


### 难点

#### 一、如何在Extenison中实现 Stored Property
Extension中不能声明一个`Stored Property`，只能声明`Computed Property`，如何间接实现`Stored Property`呢？
通过一个静态的变量来存储属性，然后以Computed Property的方式存取
```Swift
extension UIViewController {

    private static var _myComputedProperty = [String:Bool]()
    
    var myComputedProperty:Bool {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIViewController._myComputedProperty[tmpAddress] ?? false
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIViewController._myComputedProperty[tmpAddress] = newValue
        }
    }
}
```
 Linkes: [Stored Properties in Extension](https://valv0.medium.com/computed-properties-and-extensions-a-pure-swift-approach-64733768112c)