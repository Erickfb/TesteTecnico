//
//  UITapGestureRecognizer+Utils.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 19/08/24.
//

import UIKit

private var associatedObjectHandle: UInt8 = 0

extension UITapGestureRecognizer {
    var cash: Cash? {
        get {
            return objc_getAssociatedObject(self, &associatedObjectHandle) as? Cash
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectHandle,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
