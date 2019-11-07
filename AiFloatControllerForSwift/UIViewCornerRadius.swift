//
//  UIViewCornerRadius.swift
//  AiFloatControllerForSwift
//
//  Created by Aiewing on 2019/11/7.
//  Copyright © 2019 Aiewing. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    func addRoundedCorners(_ corners: UIRectCorner, radius: CGSize) {
        let rounded: UIBezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
        let share: CAShapeLayer = CAShapeLayer();
        share.path = rounded.cgPath
        layer.mask = share
    }
}
