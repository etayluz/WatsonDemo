//
//  OptionButtonCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/29/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class OptionButtonCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var optionButton: CustomButton!



    // MARK: - Properties
    weak var userChatViewCell: UserChatViewCell!

    // MARK: - Actions
    @IBAction func optionButtonTapped(_ sender: CustomButton) {
        let selectedButton = sender
        userChatViewCell.optionButtonTapped(withSelectedButton: selectedButton)
    }

    /// Configure button with option
    ///
    /// - Parameter option: button option
    func configure(withOption option: String) {
        optionButton.setTitle(option, for: .normal)
        optionButton.setTitle(option, for: .highlighted)
    }

}
