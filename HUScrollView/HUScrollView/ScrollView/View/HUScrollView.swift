//
//  HUScrollView.swift
//  HUScrollView
//
//  Created by hu on 2017/9/12.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit

enum showStauts {
    case `default`
    case toolBar
}

class HUScrollView: UIScrollView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        addSubview(imageView)
        return imageView
    }()
    var image: UIImage? {
        didSet {
            updateImage(image)
        }
    }
    
    override var frame: CGRect {
        didSet {
            updateZoomScale()
            centerScrollViewContents()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageScrollView()
        updateZoomScale()
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override public func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        centerScrollViewContents()
    }
    
    private func setupImageScrollView() {
        backgroundColor = .black
        showsVerticalScrollIndicator   = false
        showsHorizontalScrollIndicator = false
        bouncesZoom = true
        decelerationRate = UIScrollViewDecelerationRateFast
    }

    func updateImage(_ image: UIImage?) {
        let size = image?.size ?? .zero
        
        imageView.transform = .identity
        imageView.image = image
        imageView.frame = CGRect(origin: .zero, size: size)
        contentSize = size
        
        updateZoomScale()
        centerScrollViewContents()
    }
    /// 回复到中心
    private func centerScrollViewContents() {
        var horizontalInset: CGFloat = 0
        var verticalInset: CGFloat = 0
        
        if contentSize.width < bounds.width {
            horizontalInset = (bounds.width - contentSize.width) * 0.5
        }
        
        if contentSize.height < bounds.height {
            verticalInset = (bounds.height - contentSize.height) * 0.5
        }
        
        if window?.screen.scale ?? 0 < 2.0 {
            horizontalInset = floor(horizontalInset)
            verticalInset = floor(verticalInset)
        }
        
        contentInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset)
    }
    private func updateZoomScale() {
        guard let image = imageView.image else { return }
        
        let scrollViewFrame = bounds
        let scaleWidth = scrollViewFrame.size.width / image.size.width
        let scaleHeight = scrollViewFrame.size.height / image.size.height
        let minScale = min(scaleWidth, scaleHeight)
        
        minimumZoomScale = minScale
        maximumZoomScale = max(minScale, maximumZoomScale)
        
        if abs(minScale - maximumZoomScale) < 0.01 {
            maximumZoomScale = minScale * 3.0
        }
        
        zoomScale = minimumZoomScale
//        panGestureRecognizer.isEnabled = false
    }
}

