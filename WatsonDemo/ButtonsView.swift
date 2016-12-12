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
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        //iPhone 4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        //iPhone 4s
        case "iPhone4,1": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        //iPhone 5
        case "iPhone5,1", "iPhone5,2": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 5c
        case "iPhone5,3", "iPhone5,4": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 5s
        case "iPhone6,1", "iPhone6,2": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 6
        case "iPhone7,2": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 6 Plus
        case "iPhone7,1": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 6s
        case "iPhone8,1":  optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPhone 6s Plus
        case "iPhone8,2":  optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17);
        //iphone 7
        case "iPhone9,1", "iPhone9,3":  optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iphone 7 plus
        case "iPhone9,2", "iPhone9,4":  optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17);
         //iphone 7 SE
        case "iPhone8,4":  optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        //iPad2
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20);
        //iPad 3
        case "iPad3,1", "iPad3,2", "iPad3,3": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 21);
        //iPad 4
        case "iPad3,4", "iPad3,5", "iPad3,6":optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 21);
        //iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 21);
        //iPad Air 2
        case "iPad5,3", "iPad5,4": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 20);
        //iPad Mini
        case "iPad2,5", "iPad2,6", "iPad2,7": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        //iPad Mini 3
        case "iPad4,4", "iPad4,5", "iPad4,6": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        //iPad Mini 3
        case "iPad4,7", "iPad4,8", "iPad4,9": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        //iPad Mini 4
        case "iPad5,1", "iPad5,2": optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        //iPad Pro
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 23);
        //Default
        default: optionButton.titleLabel?.font = UIFont.systemFont(ofSize: 18);
        }
        
        
        
        
        
        
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
