//
//  HUUIProtocol.swift
//  HUScrollView
//
//  Created by hu on 2017/10/24.
//  Copyright © 2017年 胡佳文. All rights reserved.
//

import UIKit
import SnapKit

public protocol HUNamespaceProtocol {
    /// - aassociatedtype 关键字 用来在协议中表达参数化类型
    /// - 定义 HUNameType 为协议中的参数类型
    associatedtype nameType
    var hu: nameType { get }
    static var hu: nameType.Type { get }
}
public extension HUNamespaceProtocol {
    var hu: HUNamespaceWrapper<Self> {
        return HUNamespaceWrapper(value: self)
    }
    static var hu: HUNamespaceWrapper<Self>.Type {
        return HUNamespaceWrapper.self
    }
}
public protocol TypeWrapperProtocol {
    associatedtype nameType
    var wrappedValue: nameType { get }
    init(value: nameType)
}
/// 定义的泛型结构体 遵循 TypeWrapperProtocol 协议
public struct HUNamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}
extension UIView: HUNamespaceProtocol { }
///如果对象是引用类型的(类) 如: UIView 等 就必须使用 :
extension HUNamespaceWrapper where nameType: UIView {
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
extension String: HUNamespaceProtocol {}
/// 如果约束对象是值类型的 如: String, Date 等 就必须使用 ==
extension HUNamespaceWrapper where nameType == String {
    func test(_ string: String) -> String {
        return "hu:\(string)"
    }
}
//protocol ViewChainable {}
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

