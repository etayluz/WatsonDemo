//
//  ButtonsView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 12/5/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class ButtonsView: UIView {

    // MARK: - Properties
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var xOffset: CGFloat = 0.0
    var yOffset: CGFloat = 0.0
    var maxX: CGFloat = 0
    weak var userChatViewCell: UserChatViewCell!

    func configure(withOptions options: [String]?, viewWidth: CGFloat,  userChatViewCell: UserChatViewCell) {
        // First time around viewWidth isn't correct so hard-coding for now
        self.viewWidth = UIScreen.main.bounds.size.width * 652 / 768.0
        self.userChatViewCell = userChatViewCell
        viewHeight = 0
        xOffset = 0
        yOffset = 0
        maxX = 0

        if let options = options {
            for option in options {
                addButton(withOption: option)
            }
        } else {
            reset()
        }
    }

    func addButton(withOption option: String) {

        let optionButton = UIButton(frame: CGRect(x: xOffset, y: yOffset, width: 0, height: 0))
        optionButton.backgroundColor = UIColor.buttonBackgroundColor()
        optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        optionButton.setTitle(option, for: .normal)
        optionButton.setTitle(option, for: .highlighted)
        size(optionButton: optionButton)
        optionButton.layer.cornerRadius = 15
        optionButton.addTarget(self, action: #selector(optionButtonTapped(button:)), for: .touchUpInside)
        addSubview(optionButton)

        viewHeight = optionButton.frame.origin.y + optionButton.frame.size.height
        if maxX < optionButton.frame.origin.x + optionButton.frame.size.width  {
            maxX = optionButton.frame.origin.x + optionButton.frame.size.width
        }

        invalidateIntrinsicContentSize()
    }

    func size(optionButton: UIButton) {
        optionButton.sizeToFit()
        optionButton.frame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: optionButton.frame.width + 25,
                                    height: optionButton.frame.height)

        xOffset += optionButton.frame.width + 20

        if (xOffset > viewWidth) {
            xOffset = 0
            yOffset += optionButton.frame.height + 20
            size(optionButton: optionButton)
        }


    }

    func optionButtonTapped(button: CustomButton) {
        guard button.titleLabel?.text != "Exit" else { exit(0) }

        userChatViewCell.optionButtonTapped(withSelectedButton: button)
    }


    func reset() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
}
