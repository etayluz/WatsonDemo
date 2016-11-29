//
//  ChatInputAccessoryView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/14/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class ChatInputAccessoryView: NSObject {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var inputTextField: UITextField!

    // MARK: - Properties
    var chatViewController: ChatViewController!

    // MARK: - View Lifecycle
    override init() {
        super.init()
        setupNib()
    }

    // MARK: - Actions
    @IBAction func sendButtonTapped() {
        let userMessage = Message(type: MessageType.User, text: inputTextField.text!, options: nil)
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chatViewController.appendChat(withMessage: userMessage)
        }
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
    }

    // MARK: - Private
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }

}

// MARK: - UITextFieldDelegate
extension ChatInputAccessoryView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userMessage = Message(type: MessageType.User, text: inputTextField.text!, options: nil)
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.chatViewController.appendChat(withMessage: userMessage)
        }
        inputTextField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}
