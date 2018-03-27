//
//  HUScrollController.swift
//  HUScrollView
//
//  Created by hu on 2017/9/11.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import pop

class HUScrollController: UIViewController, UIScrollViewDelegate{

    fileprivate let scrollView = HUScrollView()
    public var image: UIImage?
    var status = showStauts.default
    let navBar = UIView()
    let bag = DisposeBag()
    ///控制状态栏属性
    var isHiddenStatus = true
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {return UIStatusBarAnimation.slide}
    override var prefersStatusBarHidden: Bool { return isHiddenStatus }
    override var preferredStatusBarStyle: UIStatusBarStyle { return UIStatusBarStyle.lightContent}
    
    public lazy private(set) var doubleTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapWithGestureRecognizer(_:)))
        gesture.numberOfTapsRequired = 2
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white

        navBar.frame = CGRect(x: 0, y: -64, width: SCREEN_WIDTH, height: 64)
        navBar.backgroundColor = UIColor.black
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
        backButton.rx.tap.subscribe(onNext: {
           self.back()
        }).disposed(by: bag);
        navBar.addSubview(backButton)
    
        scrollView.image = image
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.view.addSubview(navBar)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scrollView.imageView
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        scrollView.panGestureRecognizer.isEnabled = true
//    }
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        if (scrollView.zoomScale == scrollView.minimumZoomScale) {
//            scrollView.panGestureRecognizer.isEnabled = false
//        }
//    }
    func setupGesture() {
        view.addGestureRecognizer(doubleTapGestureRecognizer)
    }
    //刷新大图UI布局

    func back() {
        self.dismiss(animated: true)
    }
}

extension HUScrollController {
    
    @objc private func handleDoubleTapWithGestureRecognizer(_ recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.location(in: scrollView.imageView)
        var newZoomScale = scrollView.maximumZoomScale
        
        if scrollView.zoomScale >= scrollView.maximumZoomScale ||
            abs(scrollView.zoomScale - scrollView.maximumZoomScale) <= 0.01 {
            newZoomScale = scrollView.minimumZoomScale
        }
        
        let scrollViewSize = scrollView.bounds.size
        let width = scrollViewSize.width / newZoomScale
        let height = scrollViewSize.height / newZoomScale
        let originX = pointInView.x - (width / 2.0)
        let originY = pointInView.y - (height / 2.0)
        
        let rectToZoom = CGRect(x: originX, y: originY, width: width, height: height)
        scrollView.zoom(to: rectToZoom, animated: true)
    }

    
    @objc func tapAction() {
        changeStatus()
    }
    
    @objc func doubleAction() {

    }
    
    func changeStatus() {
        
        switch self.status {
        case .toolBar :
            self.status = .default
            showNavBar()
            break
        default:
            self.status = .toolBar
            hideNavBar()
            break
        }
    }
    
    func showNavBar() {
        self.isHiddenStatus = false
        UIView.animate(withDuration: 0.3) {
            self.navBar.transform = CGAffineTransform(translationX: 0, y: 64)
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func hideNavBar() {
        self.isHiddenStatus = true
        UIView.animate(withDuration: 0.3) {
            self.navBar.transform = CGAffineTransform.identity
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
