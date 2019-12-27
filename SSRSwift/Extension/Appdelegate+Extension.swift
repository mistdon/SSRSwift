//
//  Appdelegate+Extension.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/27.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import UIKit
import WebKit

extension AppDelegate{
    /// 默认配置设置
    /// - Parameters:
    ///   - applicaiton: applicaiton description
    ///   - launchOptions: launchOptions description
    func configureApplication(applicaiton: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        setupInjectionIII()
        setupConfigurationWKWebView()
        Appearance.configureNavigationBarAppearance()
    }
    func setupInjectionIII(){
        // Injections.source = "https://github.com/johnno1962/InjectionIII"
        /*
         ObjC:
         #if TARGET_IPHONE_SIMULATOR
         [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle"] load];
         #endif
         */
        #if DEBUG
            Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
        #endif
    }
    // 注册WKWbeVieww的ua
    func setupConfigurationWKWebView(){
        wkWebView = WKWebView();
        wkWebView?.evaluateJavaScript("navigator.userAgent") { [weak self](result, error) in
            let resultValue = result as? String
            guard let oldAgent = resultValue else{
                return
            }
            let newAgent = oldAgent + "/SSRSwiftiOS" // 这里添加自定义的UA
            let dict = [UD_WKUserAgent:newAgent]
            UserDefaults.standard.register(defaults: dict)
            print(SSRUserDefaults.objct(key: UD_WKUserAgent) as Any)
            self?.wkWebView!.customUserAgent = newAgent
            self?.wkWebView = nil
        }
    }
}
