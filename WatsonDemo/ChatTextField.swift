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
        inputAccessoryView = chatInputAccessoryView.contentView

        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chatInputAccessoryView.inputTextField.becomeFirstResponder()
        }
    }
    
}
