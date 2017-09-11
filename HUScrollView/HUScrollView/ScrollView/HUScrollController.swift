//
//  HUScrollController.swift
//  HUScrollView
//
//  Created by hu on 2017/9/11.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit

class HUScrollController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = true
    }
 
}
