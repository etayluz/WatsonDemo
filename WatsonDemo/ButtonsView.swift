//
//  ButtonsView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 12/5/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

protocol ButtonsViewDelegate: NSObjectProtocol {

    // MARK: - Methods
    func optionButtonTapped(withSelectedButton selectedButton: CustomButton)

}

class ButtonsView: UIView {

    // MARK: - Properties
    var viewWidth: CGFloat = UIScreen.main.bounds.size.width * 652 / 768.0
    var viewHeight: CGFloat  = 0
    var xOffset: CGFloat = 0.0
    var yOffset: CGFloat = 0.0
    var maxX: CGFloat = 0
    weak var delegate: ButtonsViewDelegate!
    var found_url = ""
    var found_reply = ""
    var buttonHasUrl = 0
    var buttonHasReply = 0
    
    func configure(withOptions options: [String]?, viewWidth: CGFloat,  delegate: ButtonsViewDelegate) {
        // First time around viewWidth isn't correct so hard-coding for now
        self.delegate = delegate
        xOffset = 0
        yOffset = 0
        maxX = 0

        reset()

        if let options = options {
            for option in options {
                addButton(withOption: option)
            }
        }
    }

    func addButton(withOption option: String) {
        var found_title = ""
        buttonHasUrl = 0
        buttonHasReply = 0
        
        print ("options is " + option)
        
        if let rangeOfZero = option.range(of: "|", options: .backwards) {
            found_title = String(option.characters.prefix(upTo: rangeOfZero.lowerBound))
            if String(option.characters.suffix(from: rangeOfZero.upperBound)).contains("http") {           found_url = String(option.characters.suffix(from: rangeOfZero.upperBound))
                buttonHasUrl = 1;
            }
            else {
                found_reply = String(option.characters.suffix(from: rangeOfZero.upperBound))
                buttonHasReply = 1;
            }
        }
        
        
        let optionButton = CustomButton(frame: CGRect(x: xOffset, y: yOffset, width: 0, height: 0))
        optionButton.backgroundColor = UIColor.buttonBackgroundColor()

        #if WATSONBANKASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONINSASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONWEALTHASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONWEALTHTASST  || DEBUG
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONMETASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONWHIRLASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONFIDASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONALFASST || DEBUG
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONREGASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONFMAEASST
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #else
            optionButton.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #endif
        
        optionButton.titleLabel?.setFont()
        
        if buttonHasReply == 1 {
            optionButton.setTitle(found_title, for: .normal)
            optionButton.setTitle(found_title, for: .highlighted)
            optionButton.buttonUse = "ButtonOnly"
            optionButton.buttonReply = found_reply
            
        }
        
        else if buttonHasUrl == 0 {
            optionButton.setTitle(option, for: .normal)
            optionButton.setTitle(option, for: .highlighted)
            optionButton.buttonUse = "ButtonOnly"
            optionButton.buttonUrl = "None"
        }
        else  {
            optionButton.setTitle(found_title, for: .normal)
            optionButton.setTitle(found_title, for: .highlighted)
            optionButton.buttonUse = "ButtonLink"
            optionButton.buttonUrl = found_url
            optionButton.backgroundColor = UIColor.blue
        }
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

        // Button text is too long to fit screen. Reduce font size.
        if (xOffset == 0 && viewWidth < optionButton.frame.width) {
            optionButton.frame = CGRect(x: xOffset,
                                        y: yOffset,
                                        width: viewWidth - 25,
                                        height: optionButton.frame.height)

            optionButton.titleLabel?.adjustsFontSizeToFitWidth = true
            optionButton.titleLabel?.numberOfLines = 0
            optionButton.titleLabel?.minimumScaleFactor = 0.2
        } else {
            xOffset += optionButton.frame.width + 20
        }

        if (xOffset > viewWidth) {
            xOffset = 0
            yOffset += optionButton.frame.height + 20
            size(optionButton: optionButton)
        }


    }

    func optionButtonTapped(button: CustomButton) {
        delegate.optionButtonTapped(withSelectedButton: button)
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
