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
    override init(frame: CGRect) { super.init(frame: frame) }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.showsVerticalScrollIndicator   = true
        self.showsHorizontalScrollIndicator = true
        //设置滑动视图
        self.backgroundColor = UIColor.black
    }
    
}

