//
//  ImageShowViewController.swift
//  SSRSwift
//
//  Created by Don.shen on 2020/5/12.
//  Copyright © 2020 Don.shen. All rights reserved.
//

import UIKit

class ImageShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "vcmodel.jpg")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
    }
}
