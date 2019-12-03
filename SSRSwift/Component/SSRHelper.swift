//
//  SSRHelper.swift
//  SSRSwift
//
//  Created by shendong on 2019/12/3.
//  Copyright © 2019 Don.shen. All rights reserved.
//

import Foundation

func VLog<T>(_ message: T, file: String = #file, funcName: String = #function, line: Int = #line){
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("file:\(fileName), funcname:\(funcName), line:\(line), message:\(message)")
    #endif
}

