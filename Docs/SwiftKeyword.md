## 关于Swift一些关键词的解释和例子

### 声明式关键字

- **associatedtype** 关联属性，在协议汇总，定一个类型的占位符名称。直到协议被实现，该占位符才会被指定为具体类型

```swift
protocol Entertainment {
    associatedtype MediaType
}
class Book: Entertainment {
    typealias MediaType = String
}
struct Movie: Entertainment {
    typealias MediaType = Int
}
```
-  **inout** : 将一个值传入函数，并可以被函数修改， 然后将值传回调用处，来替换初始值。适用于引用类型和值类型
```swift
func addOne(_ num: inout Int) {
    num += 1
}
var num = 2
addOne(&num)
print(num) // 3
```

- **typealias**: 给代码中存在的类，类型，取别名

```swift
typealias JSONDictionary = [String : AnyObject]
func parseJson(_ deserialized: JSONDictionary){}
```

- **defer**: 在函数作用域结束后执行一段代码, 常用于成对的操作
```swift
var num = 2
func addOne(value: inout  Int) -> Int{
    defer {
        value += 1
    }
    return value
}
let res = addOne(value: &num)
print(res, num) // 2, 3
```

- **guard**: 当条件不满足，直接离开作用域。同时还提供解包可选类型的功能

```swift
func checkAdultCount(_ adults: [Int]?) -> Int {
    guard let _adults = adults, _adults.count > 0 else {
        return 0
    }
    return _adults.count
}
```

- **throws**: 在函数返回前标记，表明函数可能抛出错误
```swift
enum SSRError: Error {
    case notValid
    case overload
}
func check(_ value: Int) throws -> Int {
    if value < 0 {  throw SSRError.notValid }
    return value
}
do {
    _ = try check(-9) // res = nil
} catch SSRError.notValid {
    print("notValid")
}
```

- **rethrows**: 当作为参数传入的函数抛出Error后，继续将Error向上传递

```swift
func networkCall(onComplete: () throws -> Void) rethrows{
    do{
        try onComplete()
    }
    catch {
        throw SSRError.overload
    }
}
```
- **mutating**: 允许在方法中修改`struct`或者`enum`实例的属性值
```swift
struct Person {
    private(set) var job = ""
    mutating func assignJob(newJob: String) {
        job = newJob
    }
}
var pp = Person()
pp.assignJob(newJob: "coder")
print(pp.job) // coder
```

- **optional**: 用于指明协议中的可选方法。遵循该协议的实体类可以不实现这个方法。

```swift
@objc protocol Foo{
    func requiredFunction()
    @objc optional func optionalFunction()
}

class Person : Foo{
    func requiredFunction(){
        print("Conformance is now valid")
    }
}
```
- **weak**: 弱引用，weak修饰的对象可能是nil，引用计数不加1

- **unowned**: 弱引用，修饰的对象不为nil，慎用
```swift
class Person {
    weak var pet: Pet?
    func watchPet(closure: () -> Void) {
        print("Watching pet ")
    }
    func playPet(closure: () -> Void) {
        print("Playing pet ")
    }
}
let pp = Person()

pp.watchPet { [weak self] in
    print(self?.dog?.leg) // self is optional
}
pp.playPet { [unowned self] in
    print(self.dog?.leg)  // self is not optional
}
```

## References
[throws和rethrows的用法](https://www.hackingwithswift.com/example-code/language/how-to-use-the-rethrows-keyword)
[Swift keywords](https://swift.gg/2019/08/22/Swift-Keywords/)