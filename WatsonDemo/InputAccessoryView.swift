//
//  InputAccessoryView.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/14/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class InputAccessoryView: NSObject {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var inputTextField: UITextField!

    // MARK: - View Lifecycle
    override init() {
        super.init()
        setupNib()
    }

    // MARK: - Actions
    @IBAction func sendButtonTapped() {
        inputTextField.resignFirstResponder()
        print("tapped")
    }

    // MARK: - Private
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }

}

// MARK: - UITextFieldDelegate
extension InputAccessoryView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
