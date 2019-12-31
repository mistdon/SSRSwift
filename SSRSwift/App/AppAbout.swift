//
//  AppAbout.swift
//  SSRSwift
//
//  Created by shendong on 2019/6/6.
//  Copyright © 2019 shendong. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

public struct App {
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    public static var appShortVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    public static var appStoreURL: URL {
        return URL(string: "your URL")!
    }
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    public static var screenWidth: CGFloat{
        return UIScreen.main.bounds.size.width
    }
    public static var screenHeight: CGFloat{
        return UIScreen.main.bounds.size.height
    }
    public static var statusBarHeight: CGFloat{
        return App.isX ? 44.0 : 20.0 // 处理statusBarHidden的情况
    }
    public static var systemStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    public static var navigationBarHeight: CGFloat{
        return 44.0
    }
    public static var tabBarHeight: CGFloat{
        return 44.0
    }
    public static var naviStatusHeight: CGFloat{
        return App.statusBarHeight + App.navigationBarHeight
    }
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientation.portrait.isPortrait{
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    public static var isX: Bool{
        if #available(iOS 11.0, *){
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom != 0
        }else{
            return false
        }
    }
    public static var safeAreaBottom: CGFloat{
        return isX ? 34.0 : 0.0
    }
    public static var upgradeCode: Int{
        var code = 0
        let shortVersion = App.appShortVersion
        let arr: [String] = shortVersion.components(separatedBy: ".")
        if arr.count == 3{
           let a = Int(arr[0])! * 10000
           let b = Int(arr[1])! * 100
           let c = Int(arr[2])!
           code = a + b + c
        }
        return code
    }
}
