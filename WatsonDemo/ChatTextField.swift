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
            chatViewController.chatTableBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let strongSelf = self else { return }

                strongSelf.chatViewController.view.layoutIfNeeded()
            }
            return false
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// Setup the chat text field with an input accessory view of InputAccessoryView
        chatInputAccessoryView.chatViewController = chatViewController
        inputAccessoryView = chatInputAccessoryView.contentView

        chatViewController.chatTableBottomConstraint.constant = 250

        setupSimulator()
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chatInputAccessoryView.inputTextField.becomeFirstResponder()
            let indexPath = NSIndexPath(row: self.chatViewController.messages.count - 1, section: 0) as IndexPath
            self.chatViewController.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }


    private func setupSimulator() {
        #if DEBUG
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
