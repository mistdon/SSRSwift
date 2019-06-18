# SSRSwift
Swift项目示例集锦

1、 常用内容

- Swift中GCD的使用，有一篇详尽的教程[Swift GCD](https://github.com/pmtao/DispatchQueueTest), 里面有html版和PDF版，很有帮助

2、常用第三方库的使用和DEMO
     [SwiftLint](https://github.com/realm/SwiftLint)

3、Swift知识小集

4、查看Swift的[源码](https://github.com/apple/swift)，比如Collection的isEmpty(), 源代码在[这里](https://github.com/apple/swift/blob/master/stdlib/public/core/Collection.swift#L1080-L1083)

5、 参考链接

- [如何阅读 Swift 标准库中的源码](https://swift.gg/2016/12/30/how-to-read-the-swift-standard-libray-source/)



#### 设计模式

- [单例模式](![](./DesignPattern/Singleton.swift))

## UI

- UIColor 支持多种UIColor生成

  ```swift
  let color = UIColor.colorWithHex(rgb: 0x1A1B1C, alpha: 1)
  let color = UIColor(hex6: "#62CCB0 0.5")
  let color = UIColor(hex6: "#62CCB0")
  let color = UIColor(hex8: "#F0F8FFFF")
  ```

#### component

- 图片加载

  1. iOS日常的本地图片加载，是将png图片存放在Assets文件夹中，利用苹果自带的压缩技术进行压缩。然而png的图片资源依然很大，这里我们选择使用SVG来存放本地icon.

     navi_back.svg: 249字节

     navi_png: 349字节(10 x 18),  navi_png@2x: 573字节(19* x 34), navi_png: 995字节(28 x 52)

     可以看到，三张png图片比svg的资源，大了7倍。所以可以svg是本地icon的更优的选择

     ```swift
     closeButton.setImage(SVGKImage.init(named: "navi_back.svg")?.uiImage, for: .normal)
     ```

  2. 大图片、大视频、大音频

     - 优先选择放在云端，按需下载
     - 如必要放在本地的，优化方案是进行压缩存储；使用时解压处理

   

🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉

- 如果你觉的部分代码对你有用，求Star😄
- 如果你觉的代码有问题？请提issue，或者直接和我沟通🙏

