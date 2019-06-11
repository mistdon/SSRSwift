# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

inhibit_all_warnings!

target 'SSRSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SSRSwift
  pod 'SwiftyJSON'
  # JSON to Model
  pod 'ObjectMapper', '~> 3.4'
  pod 'HandyJSON', '~> 5.0.0'
  # 网络请求
  pod 'Alamofire'
  # 图片加载
  pod 'SDWebImage'
#  pod 'Kingfisher', '~> 5.0' #最新版本支持iOS 10.0
  # Rx
  pod 'RxSwift', '~> 4.5.0'
  pod 'RxCocoa', '~> 4.5.0'
  pod 'PromiseKit'
  pod 'AlamofireImage'
  pod 'SnapKit', '~> 4.2.0'
  # 工具类
  pod 'FLEX', '~> 2.0', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX
  # 注意，这里FLEX不要升级到3.0.0，里面使用了部分的私有API，会影响送审
  pod 'SwiftLint', :configurations => ['Debug']

  pod 'ProgressHUD'
  # 测试
  target 'SSRSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SSRSwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DD_LEGACY_MACROS=1']
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
            config.build_settings['RUN_CLANG_STATIC_ANALYZER'] = 'NO'
            config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'NO'
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
