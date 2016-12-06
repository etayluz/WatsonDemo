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
        sendMessage()
    }

    // MARK: - Private
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }

    /// Send message, append it to chat view - and only then dismiss keyboard
    func sendMessage() {
        let userMessage = Message(type: MessageType.User, text: inputTextField.text!, options: nil)
        self.chatViewController.appendChat(withMessage: userMessage)
        inputTextField.text = ""

        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when + 0.2) {
            // Making animated true sometimes causes a weird glitch where the whole table is animated from the top
            self.inputTextField.resignFirstResponder()
        }


    }

}

// MARK: - UITextFieldDelegate
extension ChatInputAccessoryView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
}
