//
//  ThreadViewController.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/5/11.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import UIKit

class ThreadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thread"
        // 创建queue
        _ = DispatchQueue(label: "queue.default.serial")
        
        _ = DispatchQueue(label: "queue.default.concurrent", attributes: .concurrent)
        
        testThreadPool()
        
    }
    /// 线程池
    private final func testThreadPool() {
        let concurrentQueue = DispatchQueue(label: "queue.concurrent", attributes: .concurrent)
        let serialQuque = DispatchQueue(label: "serialQueue")
        let semaphore = DispatchSemaphore(value: 3)
        for index in 0..<10 {
            serialQuque.async {
                semaphore.wait(timeout: .distantFuture)
                concurrentQueue.async {
                    print("Thread:\(Thread.current).start.at.\(index)")
                    sleep(1)
                    print("Thread:\(Thread.current).end.at.\(index)")
                }
                semaphore.signal()
            }
        }
        print("Main Thread")
    }
    deinit {
        print(#function)
    }
}
