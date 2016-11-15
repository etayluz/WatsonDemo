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
    @IBOutlet weak var messageLabel: CustomLabel!


    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        selectionStyle = UITableViewCellSelectionStyle.none
        messageLabel.text = message.text
    }
}
