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
        
        
        #if WATSONBANKASST
            userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONINSASST
            userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONWEALTHASST
            userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONWEALTHTASST
            if GlobalConstants.UserIcon.contains("Tom") {
                userIcon.image = #imageLiteral(resourceName: "User-Tom") }
            else if GlobalConstants.UserIcon.contains("Patricia") {
                userIcon.image = #imageLiteral(resourceName: "User-Patricia") }
            else if GlobalConstants.UserIcon.contains("Luke") {
                userIcon.image = #imageLiteral(resourceName: "User-Luke") }
            else if GlobalConstants.UserIcon.contains("Jackie") {
                userIcon.image = #imageLiteral(resourceName: "User-Jackie") }
            else if GlobalConstants.UserIcon.contains("Vicki") {
                userIcon.image = #imageLiteral(resourceName: "User-Vikki") }
            else { userIcon.image = #imageLiteral(resourceName: "User") }
        #elseif WATSONMETASST
            userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONWHIRLASST
            userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONFIDASST
           userIcon.image = #imageLiteral(resourceName: "User")
        #elseif WATSONALFASST
            userIcon.image = #imageLiteral(resourceName: "User-WatsonAlfAsst")
        #elseif WATSONREGASST
            userIcon.image = #imageLiteral(resourceName: "User-WatsonRegAsst")
        #else
            userIcon.image = #imageLiteral(resourceName: "User")
        #endif
    
        
        self.message = message

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }
        
        messageLabel.setFont()
        messageLabel.removeXML()
        buttonsView.configure(withOptions: message.options,
                              viewWidth: buttonsView.frame.width,
                              delegate: self)

        initialButtonsLeadingConstraint = initialButtonsLeadingConstraint ?? buttonsLeadingConstraint.constant
        buttonsLeadingConstraint.constant = initialButtonsLeadingConstraint + (buttonsView.viewWidth - buttonsView.maxX)/2

        messageBackground.isHidden = message.options != nil ? true : false
        messageLabel.isHidden = message.options != nil ? true : false
        rightTriangleView.isHidden = message.options != nil ? true : false
        userIcon.isHidden = message.options != nil ? true : false
        userIcon.layer.cornerRadius = userIcon.frame.width / 2
        userIcon.clipsToBounds = true
    }


    // MARK: - Private
    /// Once the user has tapped an option button, the cell needs to be resized and so we reload it to shrink it
    func reloadCell() {
        // This is needed to resize the ButtonsView correctly
        if let indexPath = self.chatViewController?.chatTableView.indexPath(for: self) {
            self.chatViewController?.chatTableView.reloadRows(at: [indexPath], with: .none)
            self.chatViewController?.scrollChatTableToBottom()
        }
    }


}


// MARK: - ButtonsViewDelegate
extension UserChatViewCell: ButtonsViewDelegate {

    func optionButtonTapped(withSelectedButton selectedButton: CustomButton) {
        print ("buttonUse is " + selectedButton.buttonUse!)
        print ("buttonUrl is " + selectedButton.buttonUrl!)

        if (selectedButton.buttonUse?.range(of: "ButtonOnly", options: .backwards)) != nil {
            message?.options = nil
            message?.text = selectedButton.titleLabel?.text

            /// Update message
            if let indexPath = chatViewController?.chatTableView.indexPath(for: self),
                let message = message {
                chatViewController?.messages[indexPath.row] = message
                chatViewController?.dismissKeyboard()
            }
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
                if (selectedButton.buttonUse?.range(of: "ButtonOnly", options: .backwards)) != nil {
                    self.chatViewController?.conversationService.sendMessage(withText: (selectedButton.titleLabel?.text!)!)}
        })

        if (selectedButton.buttonUse?.range(of: "ButtonLink", options: .backwards)) != nil {
            let url = URL(string: selectedButton.buttonUrl!)
            if UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
}
