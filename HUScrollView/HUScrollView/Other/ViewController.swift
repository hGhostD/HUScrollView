//
//  ViewController.swift
//  HUScrollView
//
//  Created by 胡佳文 on 2017/9/10.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 0, green: 147/255, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        self.view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalTo(self.view.snp.center)
            $0.width.equalTo(120)
            $0.center.equalTo(40)
        }
        button.rx.tap.subscribe(onNext: {
            self.navigationController?.pushViewController(HUScrollController(), animated: true)
        }).addDisposableTo(bag)
    }
}

