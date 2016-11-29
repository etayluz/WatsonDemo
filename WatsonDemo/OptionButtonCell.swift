//
//  OptionButtonCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/29/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class OptionButtonCell: UICollectionViewCell {

    @IBOutlet weak var optionButton: CustomButton!

    override func awakeFromNib() {

    }

    
    /// Configure button with option
    ///
    /// - Parameter option: button option
    func configure(withOption option: String) {
        optionButton.setTitle(option, for: .normal)
        optionButton.setTitle(option, for: .highlighted)
    }

}
