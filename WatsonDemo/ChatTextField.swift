//
//  ChatTextField.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/14/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class ChatTextField: UITextField {

    /// Setup the chat text field with an input accessory view of InputAccessoryView
    override func awakeFromNib() {
        let inputAccessoryView = InputAccessoryView()
        self.inputAccessoryView = inputAccessoryView.contentView
    }

}
