//
//  BarscoreViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 3/31/17.
//  Copyright © 2017 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class BarscoreViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var barscoreView: UIImageView!
    @IBOutlet weak var barscoreLabel: CustomLabel!
    @IBOutlet weak var barscoreLeadingConstraint: NSLayoutConstraint!

    // MARK: - Properties
    weak var delegate: ChatViewController!
    var hasReloaded = false

    /// Configure retirement barscore
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message, delegate: ChatViewController) {

        barscoreLabel.text = message.barscore
        barscoreLabel.cornerRadius = barscoreLabel.frame.width / 2
        barscoreLabel.textAlignment = .center

        let barscorePercentage = Float((message.barscore?.replacingOccurrences(of: "%", with: ""))!)! / 100
        let startOffset = Float(62/975.0 * barscoreView.frame.width)
        let barscoreWidth = Float((Float(barscoreView.frame.width) - startOffset * 2))
        barscoreLeadingConstraint.constant = CGFloat(startOffset + barscoreWidth * barscorePercentage)

        // The barscoreView contraints are NOT laid out when cell is first allocated, so need to reload it
        if (hasReloaded == false) {
            hasReloaded = true
            delegate.chatTableView.reloadData()
        }
    }

}
