//
//  ChatTextField.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/14/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class ChatTextField: UITextField {

    // MARK: - Properties
    let chatInputAccessoryView = ChatInputAccessoryView()
    var chatViewController: ChatViewController!
    var debugChatIndex = 1

    // MARK: - View Lifecycle
    override func awakeFromNib() {
        delegate = self
    }

}

// MARK: - UITextFieldDelegate
extension ChatTextField: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
        guard inputAccessoryView == nil else {
            inputAccessoryView = nil
            chatViewController.chatTableBottomConstraint.constant = 15

            /// Animate chatTable down with dismissal of keyboard and scroll to last row
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.chatViewController.view.layoutIfNeeded()
                strongSelf.chatViewController.scrollChatTableToBottom()
            }

            return false
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupSimulator()

        /// Setup the chat text field with an input accessory view of InputAccessoryView
        chatInputAccessoryView.chatViewController = chatViewController
        inputAccessoryView = chatInputAccessoryView.contentView

        /// Animate chatTable up with showing of keyboard
        chatViewController.chatTableBottomConstraint.constant = 250

        // I'm not sure why this delay is needed but without it the keyboard won't dismiss
        let when = DispatchTime.now() + 0.01
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 0.05) { [weak self] in
                self?.chatViewController.view.layoutIfNeeded()
                self?.chatInputAccessoryView.inputTextField.becomeFirstResponder()
                self?.chatViewController.scrollChatTableToBottom()
            }
        }
    }


    private func setupSimulator() {
        #if DEBUG
//            chatInputAccessoryView.inputTextField.text = "Testing testing testing testing testing testing Testing testing testing testing testing testing"
//            return
            if (debugChatIndex == 1) {
                chatInputAccessoryView.inputTextField.text = "I received an alert on a suspicious transaction"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 2) {
                chatInputAccessoryView.inputTextField.text = "Can I use my debt card in the US"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 3) {
                chatInputAccessoryView.inputTextField.text = "Yes, Please"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 4) {
                chatInputAccessoryView.inputTextField.text = "Savings"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 5) {
                chatInputAccessoryView.inputTextField.text = "Checking"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 6) {
                chatInputAccessoryView.inputTextField.text = "Will I have to pay a fee for taking cash out"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 7) {
                chatInputAccessoryView.inputTextField.text = "What are the exchange rates"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 8) {
                chatInputAccessoryView.inputTextField.text = "Yea"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 9) {
                chatInputAccessoryView.inputTextField.text = "Thanks for the advice"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 10) {
                chatInputAccessoryView.inputTextField.text = "Thanks for the advice"
                debugChatIndex = debugChatIndex + 1
            }
        #endif

    }
    
}
