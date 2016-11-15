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
        chatViewController.addUserChat(withMessage: inputTextField.text!)
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
        chatViewController.addUserChat(withMessage: inputTextField.text!)
        inputTextField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}
