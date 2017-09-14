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

class HUScrollController: UIViewController {

    fileprivate let scrollView = HUScrollView()
    fileprivate let imageView  = UIImageView()
    public var image = Variable<UIImage>(UIImage())
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
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
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
        let imageSize = HUExtensionTool.getImageSize(self.image.value)
        imageView.snp.makeConstraints {
            $0.center.equalTo(scrollView)
            $0.size.equalTo(imageSize)
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tap)
        
        let double = UITapGestureRecognizer(target: self, action: #selector(doubleAction))
        double.numberOfTapsRequired = 2
        tap.require(toFail: double)
        scrollView.addGestureRecognizer(double)
    }

    func setupRxSwift() {
        self.image.asObservable().subscribe(onNext: {
            self.imageView.image = $0
        }).addDisposableTo(bag)
    }
    
    //刷新大图UI布局
    func reloadImageView() {
        let imageSize = HUExtensionTool.getImageSize(self.image.value)
        imageView.snp.remakeConstraints {
            $0.center.equalTo(scrollView)
            $0.size.equalTo(imageSize)
        }
    }
    
    func blowUpImageView() {
        let imageSize = HUExtensionTool.getImageMaxSize(self.image.value)
        imageView.snp.remakeConstraints {
            $0.size.equalTo(imageSize)
            $0.center.equalTo(scrollView)
            $0.left.right.equalTo(0)
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HUScrollController {
    
    
    func tapAction() {
        changeStatus()
    }
    
    func doubleAction() {
        if imageView.frame.size.width > SCREEN_WIDTH ||
            imageView.frame.size.height > SCREEN_HEIGHT {
            reloadImageView()
        }else {
            blowUpImageView()
        }
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
