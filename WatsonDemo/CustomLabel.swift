//
//  CustomLabel.swift
//
//  Created by Etay Luz on 8/23/16.
//


import UIKit

@IBDesignable class CustomLabel: UILabel {

    // MARK: - Constants
    private struct Constants {
        static let lineSpacing: CGFloat = 5.0
    }

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
        
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset

        return adjSize
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset

        return contentSize
    }

    override var text: String? {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = Constants.lineSpacing

            let attrString = NSMutableAttributedString(string: text!)
            attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

            attributedText = attrString
        }
    }

}
