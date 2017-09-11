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

    private let scrollView = UIScrollView()
    private let imageView  = UIImageView()
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    ///控制状态栏属性
    var isHiddenStatus = true
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {return UIStatusBarAnimation.slide}
    override var prefersStatusBarHidden: Bool {return isHiddenStatus}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSnpKit()
        reloadImageView()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true

        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    func setupSnpKit() {
        scrollView.snp.makeConstraints {
            $0.left.top.right.bottom.equalTo(0)
        }

    }

    //刷新大图UI布局
    func reloadImageView() {
        let imageSize = HUExtensionTool.getImageSize(self.image!)
        scrollView.contentSize = imageSize
        imageView.snp.makeConstraints {
            $0.center.equalTo(scrollView.center)
            $0.size.equalTo(imageSize)
        }
    }
}
