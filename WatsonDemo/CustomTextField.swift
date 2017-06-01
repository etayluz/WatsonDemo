//
//  CustomView.swift
//  Startbox
//
//  Created by Etay Luz on 8/20/16.
//  Copyright © 2016 Startbox. All rights reserved.
//

import CoreGraphics
import UIKit

@IBDesignable final class CustomTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0


    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }


    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
