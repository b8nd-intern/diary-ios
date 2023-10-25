//
//  UINavigationController+Ext.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 10/23/23.
//

import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
