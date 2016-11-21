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
    var message: Message?
    var chatViewController: ChatViewController?

    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message
        messageLabel.text = message.text

        if let _ = message.options {
            messageBackground.isHidden = true
            rightTriangleView.isHidden = true
            userIcon.isHidden = true

            if (message.options?.count)! <= 2 {
                buttonThree.isHidden = true
            }
            if (message.options?.count)! <= 1 {
                buttonTwo.isHidden = true
            }
            if (message.options?.count)! == 0 {
                buttonOne.isHidden = true
            }

        } else {
            buttonOne.isHidden = true
            buttonTwo.isHidden = true
            buttonThree.isHidden = true
            messageBackground.isHidden = false
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
        }

        /// Hide all buttons except for selected button
        buttonOne.isHidden = true
        buttonTwo.isHidden = true
        buttonThree.isHidden = true

        userIcon.isHidden = false

        /// Show selected button and change its background color to white
        selectedButton.isHidden = false
        selectedButton.backgroundColor = UIColor.white
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)

        UIView.animate(withDuration: 0.5, animations: {
            let constraintOffset = self.userIcon.frame.origin.x - selectedButton.frame.origin.x - selectedButton.frame.size.width - 15
            self.buttonsLeadingConstraint.constant += constraintOffset
            selectedButton.superview?.layoutIfNeeded()
        }, completion: nil)
    }

}

