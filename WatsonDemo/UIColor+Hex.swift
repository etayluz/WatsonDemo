//
//  UIColor+Hex.swift
//
//  Created by Etay Luz on 8/09/16.
//

import UIKit


extension UIColor {
    
    static func colorWithRGBHex(hex24: UInt) -> UIColor {
        return UIColor(
            red:    (CGFloat)((hex24 & 0xFF0000) >> 16) / 255.0,
            green:  (CGFloat)((hex24 & 0x00FF00) >> 8) / 255.0,
            blue:   (CGFloat)((hex24 & 0x0000FF) >> 0) / 255.0,
            alpha:  1.0)
    }

    static func colorWithRGBHex(hex24: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red:    (CGFloat)((hex24 & 0xFF0000) >> 16) / 255.0,
            green:  (CGFloat)((hex24 & 0x00FF00) >> 8) / 255.0,
            blue:   (CGFloat)((hex24 & 0x0000FF) >> 0) / 255.0,
            alpha:  alpha)
    }

    class func buttonBackgroundColor() -> UIColor {
        return colorWithRGBHex(hex24: 0xdb1f38)
    }

}
