1. `Self` 和 `self`，两者区别是什么？
     当使用协议或者协议的扩展时，`Self` 和 `self` 是有很大区别。`Self`表示遵守该协议的类型，而`self`表示该类型的值.
     
     ```swift
     protocol BinaryInteger {
         func squared() -> Self
     }
     extension Int : BinaryInteger{
         func squared() -> Int {
             return self * self
         }
     }
     let a = 10
     a.squared()  // 100
     ```
     
     Links: [Self vs self - what's the difference?](https://www.hackingwithswift.com/example-code/language/self-vs-self---whats-the-difference)

