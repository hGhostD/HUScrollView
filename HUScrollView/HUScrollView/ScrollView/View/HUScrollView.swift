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

extension HUScrollController {
    
    
    func tapAction() {
        changeStatus()
    }
    
    func doubleAction() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
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
        UIView.animate(withDuration: 0.5) { 
            self.navBar.transform = CGAffineTransform(translationX: 0, y: 64)
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func hideNavBar() {
        self.isHiddenStatus = true
        UIView.animate(withDuration: 0.5) { 
            self.navBar.transform = CGAffineTransform.identity
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
