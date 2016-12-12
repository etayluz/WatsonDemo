//
//  UserChatViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class UserChatViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var buttonsView: ButtonsView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightTriangleView: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!


    // MARK: - Constraints
    @IBOutlet weak var buttonsLeadingConstraint: NSLayoutConstraint!

    // MARK: - Properties
    var chatViewController: ChatViewController?
    var initialButtonsLeadingConstraint: CGFloat!
    var message: Message?


    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        //iPhone 4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": messageLabel.font = UIFont(name: "Arial", size: 12.0);
        //iPhone 4s
        case "iPhone4,1": messageLabel.font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5
        case "iPhone5,1", "iPhone5,2": messageLabel.font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5c
        case "iPhone5,3", "iPhone5,4": messageLabel.font = UIFont(name: "Arial", size: 12.0);
        //iPhone 5s
        case "iPhone6,1", "iPhone6,2": messageLabel.font = UIFont(name: "Arial", size: 12.0);
        //iPhone 6
        case "iPhone7,2": messageLabel.font = UIFont(name: "Arial", size: 14.0);
        //iPhone 6 Plus
        case "iPhone7,1": messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPhone 6s
        case "iPhone8,1":  messageLabel.font = UIFont(name: "Arial", size: 14.0);
        //iPhone 6s Plus
        case "iPhone8,2":  messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iphone 7
        case "iPhone9,1", "iPhone9,3":  messageLabel.font = UIFont(name: "Arial", size: 14.0);
        //iphone 7 plus
        case "iPhone9,2", "iPhone9,4":  messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPhone SE
        case "iPhone8,4":  messageLabel.font = UIFont(name: "Arial", size: 14.0);
        //iPad2
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":messageLabel.font = UIFont(name: "Arial", size: 20.0);
        //iPad 3
        case "iPad3,1", "iPad3,2", "iPad3,3": messageLabel.font = UIFont(name: "Arial", size: 20.0);
        //iPad 4
        case "iPad3,4", "iPad3,5", "iPad3,6":messageLabel.font = UIFont(name: "Arial", size: 20.0);
        //iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":messageLabel.font = UIFont(name: "Arial", size: 20.0);
        //iPad Air 2
        case "iPad5,3", "iPad5,4": messageLabel.font = UIFont(name: "Arial", size: 20.0);
        //iPad Mini
        case "iPad2,5", "iPad2,6", "iPad2,7": messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 3
        case "iPad4,4", "iPad4,5", "iPad4,6": messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 3
        case "iPad4,7", "iPad4,8", "iPad4,9": messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPad Mini 4
        case "iPad5,1", "iPad5,2": messageLabel.font = UIFont(name: "Arial", size: 16.0);
        //iPad Pro
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":messageLabel.font = UIFont(name: "Arial", size: 22.0);
        //default
        default: messageLabel.font = UIFont(name: "Arial", size: 18.0);
        }
        
        
        buttonsView.configure(withOptions: message.options,
                              viewWidth: buttonsView.frame.width,
                              userChatViewCell: self)

        initialButtonsLeadingConstraint = initialButtonsLeadingConstraint ?? buttonsLeadingConstraint.constant
        buttonsLeadingConstraint.constant = initialButtonsLeadingConstraint + (buttonsView.viewWidth - buttonsView.maxX)/2

        messageBackground.isHidden = message.options != nil ? true : false
        messageLabel.isHidden = message.options != nil ? true : false
        rightTriangleView.isHidden = message.options != nil ? true : false
        userIcon.isHidden = message.options != nil ? true : false
        userIcon.layer.cornerRadius = userIcon.frame.width / 2
        userIcon.clipsToBounds = true
    }

    // MARK: - Actions
    func optionButtonTapped(withSelectedButton selectedButton: CustomButton) {

        message?.options = nil
        message?.text = selectedButton.titleLabel?.text

        /// Update message
        if let indexPath = chatViewController?.chatTableView.indexPath(for: self),
           let message = message {
            chatViewController?.messages[indexPath.row] = message
            chatViewController?.dismissKeyboard()
        }

        userIcon.isHidden = false
        addSubview(selectedButton)
        buttonsView.reset()

        selectedButton.frame = CGRect(x: selectedButton.frame.origin.x + buttonsView.frame.origin.x,
                                      y: selectedButton.frame.origin.y + buttonsView.frame.origin.y,
                                      width: selectedButton.frame.size.width,
                                      height: selectedButton.frame.size.height)
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        selectedButton.backgroundColor = UIColor.white
        selectedButton.translatesAutoresizingMaskIntoConstraints = false
        selectedButton.trailingAnchor.constraint(equalTo: userIcon.leadingAnchor, constant: -15).isActive = true
        selectedButton.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor).isActive = true
        selectedButton.widthAnchor.constraint(equalToConstant: selectedButton.frame.width).isActive = true

        UIView.animate(withDuration: 0.5, delay: 0, animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: { result in
            selectedButton.removeFromSuperview()
            self.reloadCell()
            self.chatViewController?.conversationService.sendMessage(withText: (selectedButton.titleLabel?.text!)!)
        })
    }

    // MARK: - Private
    /// Once the user has tapped an option button, the cell needs to be resized and so we reload it to shrink it
    private func reloadCell() {
        // This is needed to resize the ButtonsView correctly
        if let indexPath = self.chatViewController?.chatTableView.indexPath(for: self) {
            self.chatViewController?.chatTableView.reloadRows(at: [indexPath], with: .none)
            self.chatViewController?.scrollChatTableToBottom()
        }
    }


}
