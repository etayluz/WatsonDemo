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
            return false
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// Setup the chat text field with an input accessory view of InputAccessoryView
        chatInputAccessoryView.chatViewController = chatViewController
        inputAccessoryView = chatInputAccessoryView.contentView

        setupSimulator()
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chatInputAccessoryView.inputTextField.becomeFirstResponder()
        }
    }


    private func setupSimulator() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            if (debugChatIndex == 1) {
                chatInputAccessoryView.inputTextField.text = "I received an alert on a suspicious transaction"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 2) {
                chatInputAccessoryView.inputTextField.text = "No"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 3) {
                chatInputAccessoryView.inputTextField.text = "No"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 4) {
                chatInputAccessoryView.inputTextField.text = "Watson"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 5) {
                chatInputAccessoryView.inputTextField.text = "Yes"
                debugChatIndex = debugChatIndex + 1
            }
            else if (debugChatIndex == 6) {
                chatInputAccessoryView.inputTextField.text = "Visit Branch"
                debugChatIndex = debugChatIndex + 1
            }
        #endif

    }
    
}
