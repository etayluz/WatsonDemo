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
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightTriangleView: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!

    // MARK: - Buttons
    @IBOutlet weak var buttonOne: CustomButton!
    @IBOutlet weak var buttonTwo: CustomButton!
    @IBOutlet weak var buttonThree: CustomButton!

    // MARK: - Constraints
    @IBOutlet weak var buttonsLeadingConstraint: NSLayoutConstraint!

    // MARK: - Properties
    var buttons = [UIButton]()
    var message: Message?
    var chatViewController: ChatViewController?


    override func awakeFromNib() {
        buttons.append(buttonOne)
        buttons.append(buttonTwo)
        buttons.append(buttonThree)
    }

    override func prepareForReuse() {
        if let numberOfOptions = message?.options?.count {
            if numberOfOptions >= 3 {
                buttonsLeadingConstraint.constant = frame.size.width / 2 - 160
            } else if numberOfOptions == 2 {
                buttonsLeadingConstraint.constant = frame.size.width / 2 - 80
            } else if numberOfOptions == 1 {
                buttonsLeadingConstraint.constant = frame.size.width / 2 - 30
            }
        }
        messageBackground.isHidden = false
        messageLabel.isHidden = false
        rightTriangleView.isHidden = false
        userIcon.isHidden = false
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true
        buttonOne.backgroundColor = UIColor.buttonBackgroundColor()
        buttonTwo.backgroundColor = UIColor.buttonBackgroundColor()
        buttonThree.backgroundColor = UIColor.buttonBackgroundColor()
        buttonOne.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonTwo.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonThree.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message
        prepareForReuse()

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }

        if let options = message.options {
            messageBackground.isHidden = true
            messageLabel.isHidden = true
            rightTriangleView.isHidden = true
            userIcon.isHidden = true

            for (index, option) in options.enumerated() {
                buttons[index].setTitle(option, for: UIControlState.normal)
                buttons[index].setTitle(option, for: UIControlState.highlighted)
                buttons[index].isHidden = false
            }
        } else {
            buttonOne.isHidden = true
            buttonTwo.isHidden = true
            buttonThree.isHidden = true
            messageBackground.isHidden = false
            messageLabel.isHidden = false
            rightTriangleView.isHidden = false
            userIcon.isHidden = false
        }
    }

    // MARK: - Actions
    @IBAction func optionButtonTapped(_ sender: CustomButton) {
        let selectedButton = sender

        message?.options = nil
        message?.text = selectedButton.titleLabel?.text

        /// Update message
        if let indexPath = chatViewController?.chatTableView.indexPath(for: self),
           let message = message {
            chatViewController?.messages[indexPath.row] = message
            chatViewController?.conversationService.sendMessage(withText: message.text!)
            chatViewController?.dismissKeyboard()
        }

        /// Hide all buttons except for selected button
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true

        userIcon.isHidden = false

        /// Show selected button and change its background color to white
        selectedButton.isHidden = false
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        selectedButton.backgroundColor = UIColor.white

        UIView.animate(withDuration: 0.5, animations: {
            let constraintOffset = self.userIcon.frame.origin.x - selectedButton.frame.origin.x - selectedButton.frame.size.width - 15
            self.buttonsLeadingConstraint.constant += constraintOffset
            selectedButton.superview?.layoutIfNeeded()
        }, completion: { result in
            selectedButton.isHidden = true
            self.messageLabel.text = selectedButton.titleLabel?.text
            self.prepareForReuse()
        })
    }

}

