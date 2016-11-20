//
//  CustomButton.swift
//
//  Created by Etay Luz on 8/23/16.
//

import UIKit

@IBDesignable final class CustomButton: UIButton {

    override func awakeFromNib() {
        if let title = titleLabel?.text {
            titleLabel!.text = NSLocalizedString(title, comment: "")
        }

        for state in [UIControlState.normal, UIControlState.normal,
                      UIControlState.highlighted, UIControlState.selected, UIControlState.disabled] {
            if let title = title(for: state) {
                setTitle(NSLocalizedString(title, comment: ""), for: state)
            }
        }
    }

    // MARK: - Properties
    var leadingConstraint: NSLayoutConstraint?

    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable var shadowOffset: CGFloat = 0 {
        didSet {
            layer.shadowOffset = CGSize(width: 0, height: shadowOffset)
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += 20

        return contentSize
    }
}
