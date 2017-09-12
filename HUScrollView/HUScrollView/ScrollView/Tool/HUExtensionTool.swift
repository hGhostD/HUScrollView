//
//  HUExtensionTool.swift
//  HUScrollView
//
//  Created by 胡佳文 on 2017/9/11.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class HUExtensionTool: NSObject {
    class func getImageSize(_ image: UIImage) -> CGSize {
        let width = image.size.width
        let height = image.size.height
        //这里减去2个导航栏高度作为高度的最大值
        let screenScale = SCREEN_WIDTH / (SCREEN_HEIGHT - 128)
        let scale = width / height
        if scale > screenScale {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH / scale)
        }else {
            return CGSize(width: (SCREEN_HEIGHT - 128) * scale, height: SCREEN_HEIGHT - 128)
        }
    }
    
    class func getImageMaxSize(_ image: UIImage) -> CGSize {
        let width = image.size.width
        let height = image.size.height
        //这里减去2个导航栏高度作为高度的最大值
        let screenScale = SCREEN_WIDTH / (SCREEN_HEIGHT - 128)
        let scale = width / height
        if scale > screenScale {
            return CGSize(width: (SCREEN_HEIGHT - 128) * scale, height: SCREEN_HEIGHT - 128)
        }else {
            return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH / scale)
        }
    }
}
