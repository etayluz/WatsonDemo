//
//  CheckboxTableViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 3/23/17.
//  Copyright © 2017 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class CheckboxTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!

    /// Configure checkbox with option
    ///
    /// - Parameter option: Option string
    func configure(withOption option: String) {
        optionLabel.text = option
    }
    
}
