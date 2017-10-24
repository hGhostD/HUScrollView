//
//  HUUIProtocol.swift
//  HUScrollView
//
//  Created by hu on 2017/10/24.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit
import SnapKit

public protocol HUNamespace {
    associatedtype WrapperType
    var hu: WrapperType { get }
    static var hu: WrapperType.Type { get }
}
public extension HUNamespace {
    var hu: HUNamespaceWrapper<Self> {
        return HUNamespaceWrapper(value: self)
    }
    static var hu: HUNamespaceWrapper<Self>.Type {
        return HUNamespaceWrapper.self
    }
}
public struct HUNamespaceWrapper<T> {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}
extension UIView: HUNamespace { }
extension HUNamespaceWrapper where T: UIView {
    public func adhere(_ toSuperView: UIView) -> T {
        toSuperView.addSubview(wrappedValue)
        return wrappedValue
    }
    @discardableResult
    public func layout(_ snapKitMaker: (ConstraintMaker) -> Void) -> T {
        wrappedValue.snp.makeConstraints {
            snapKitMaker($0)
        }
        return wrappedValue
    }
    @discardableResult
    public func config(_ config: (T) -> Void) -> T {
        config(wrappedValue)
        return wrappedValue
    }
}
//protocol ViewChainable {}
//
//extension ViewChainable where Self: UIView {
//    @discardableResult
//    func config(_ config: (Self) -> Void) -> Self {
//        config(self)
//        return self
//    }
//}
//
//extension UIView: ViewChainable {
//    func adhere(_ toSupView: UIView) -> Self {
//        toSupView.addSubview(self)
//        return self
//    }
//    
//    @discardableResult
//    func layout(snapKitMaker: (ConstraintMaker) -> Void) -> Self {
//        self.snp.makeConstraints {
//            snapKitMaker($0)
//        }
//        return self
//    }
//}

