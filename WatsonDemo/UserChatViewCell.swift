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
        
        messageLabel.setFont()
        messageLabel.removeXML()
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
