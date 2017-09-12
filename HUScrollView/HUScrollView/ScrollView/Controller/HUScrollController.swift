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

class HUScrollController: UIViewController {

    let scrollView = UIScrollView()
    let imageView  = UIImageView()
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var status = showStauts.default
    let navBar = UIView()
    let bag = DisposeBag()
    ///控制状态栏属性
    var isHiddenStatus = true
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {return UIStatusBarAnimation.slide}
    override var prefersStatusBarHidden: Bool {return isHiddenStatus}
    override var preferredStatusBarStyle: UIStatusBarStyle {return UIStatusBarStyle.lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSnpKit()
        setupGesture()
        setupRxSwift()
        reloadImageView()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        //设置滑动视图
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.black
        
        imageView.isUserInteractionEnabled = true
        
        navBar.frame = CGRect(x: 0, y: -64, width: SCREEN_WIDTH, height: 64)
        navBar.backgroundColor = UIColor.black
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
        backButton.rx.tap.subscribe(onNext: {
           self.back()
        }).addDisposableTo(bag);
        navBar.addSubview(backButton)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        self.view.addSubview(navBar)

    }

    func setupSnpKit() {
        scrollView.snp.makeConstraints {
            $0.left.top.right.bottom.equalTo(0)
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        imageView.addGestureRecognizer(tap)
        
        let double = UITapGestureRecognizer(target: self, action: #selector(doubleAction))
        double.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(double)
    }

    func setupRxSwift() {

    }
    
    //刷新大图UI布局
    func reloadImageView() {
        let imageSize = HUExtensionTool.getImageSize(self.image!)
        scrollView.contentSize = imageSize
        imageView.bounds.size = imageSize
        imageView.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
