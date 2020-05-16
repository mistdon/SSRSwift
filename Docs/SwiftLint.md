### SwiftLint

测试环境: **Xcode 11.4**

SwiftLint是代码规范工具

#### Installing

1. 通过Pod引入
   `pod 'SwiftLint'`
2. 在`Target` -> `BuildPhases` -> `New Run Script Phase`  -> `Run Scipt`中添加
   `"${PODS_ROOT}/SwiftLint/swiftlint"`
3. 在根目录下创建`.swiftlint.yml`文件
   `touch .swiftlint.yml`
   在这里添加自定义规则，可以看该项目中的规范

 > 这个是隐藏文件夹, 可以通过`cmd + shift + .`在finder中查看隐藏文件夹

`Build`即可看到很多报错和⚠️

#### 自定义规范

由于SwiftLint官方规范过于严格，我们可以在`.swiftlint.yml`中更改和添加自定义规范

可以在官网上查看所有的[规则](https://realm.github.io/SwiftLint/index.html)，并根据规则去调整代码

参考代码规范：[swiftlint.yml](https://github.com/mistdon/SSRSwift/blob/master/Docs/SwiftLint.md)

###### 在文件内禁用规则

1. 禁用全部规则(在文件的顶部配置)：

```swift
// swiftlint:disable all
```

2. 禁用部分规则：
// swiftlint:disable colon
let noWarning :String = "" // No warning about colons immediately after variable names!

```swift
// swiftlint:disable all
```

###### 首先禁用部分规则
```yml
disabled_rules: # 执行时排除掉的规则
  - colon
  - comma
  - control_statement
  - missing_docs
```

###### 常见配置项
- variable_name:min_length: error: 1 

  变量名的最小长度,一般可以根据项目更改为不报错即可

#### 常见问题

 1. `Command PhaseScriptExecution failed with a nonzero exit code`

    解决办法: 在`File>WorkSpcae Settings>Build System`，修改为`Legacy Build System`

 2. `Shell Script Invocation Error`

    解决办法: 在`.swiftlint.yml`中，将`included`下的` - Source`注释掉，这个是`include`错误