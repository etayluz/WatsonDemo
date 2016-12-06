//
//  WatsonChatViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class WatsonChatViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var watsonIcon: UIImageView!

    /// Configure Watson chat table view cell with Watson message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        messageLabel.text = message.text

        #if WESTFIELD
            watsonIcon.image = UIImage.blueWatsonIcon()
        #endif
    }

}
