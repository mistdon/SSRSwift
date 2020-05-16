//
//  PhotoViewer.swift
//  SSRSwift
//
//  Created by Don.shen on 2019/6/29.
//  Copyright © 2019 Don.shen. All rights reserved.
//
// swiftlint:disable all

import UIKit

struct PhotoItem {
    
    var thumbView : UIView?
    
    var thumbImage: UIImage?
    
    var largeImageSize: CGSize?
    
    var largeImageURL: String?
}
class PhotoViewerCell: UIScrollView {
    var imageContainerView = UIView()
    var imageView = UIImageView()
    var page: Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit(){
        self.delegate = self;
        self.bouncesZoom = true;
        self.maximumZoomScale = 10;
        self.isMultipleTouchEnabled = true;
        self.alwaysBounceVertical = false;
        self.showsVerticalScrollIndicator = true;
        self.showsHorizontalScrollIndicator = false;
        self.frame = UIScreen.main.bounds;
        if #available(iOS 11.0, *){
            self.contentInsetAdjustmentBehavior = .never
        }
        imageContainerView.clipsToBounds = true
        self.addSubview(imageContainerView)
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.white
        imageContainerView.addSubview(imageView)
    }
    func bindItem(item: PhotoItem){
        self.imageView.sd_setImage(with: nil, completed: nil)
    }
}
extension PhotoViewerCell: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageContainerView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let compare = scrollView.bounds.size.width > scrollView.contentSize.width
        print(compare)
    }
}
class PhotoViewer: UIView{
    var items = [PhotoItem]()
    var currentPage : Int = 0
    
    convenience init(items: [PhotoItem], frame: CGRect) {
        self.init(frame: frame) // error fixed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func present(from fromView: UIView, to toView: UIView, animation: Bool, completion: () -> Void){
        
    }
    func dismiss(animation: Bool, completion: () -> Void){
        
    }
}
