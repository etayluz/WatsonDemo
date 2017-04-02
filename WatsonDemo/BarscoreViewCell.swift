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
    @IBOutlet weak var barscore: UIImageView!
    @IBOutlet weak var barscoreLabel: CustomLabel!
    

    // MARK: - Properties
    weak var delegate: ChatViewController!
    var hasReloaded = 0

    /// Configure retirement barscore
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message, delegate: ChatViewController) {

        barscoreLabel.text = message.barscore
        barscoreLabel.textAlignment = .center

        var barscorePercentage: CGFloat = 0
        let barscorePercentageString = message.barscore?.replacingOccurrences(of: "%", with: "")
        if let doubleValue = Double(barscorePercentageString!) {
          barscorePercentage = CGFloat(doubleValue) / 100 * 0.85
        }

        // Need a delay here because the constraints don't get translated to frames until later
        let when = DispatchTime.now() + 0.05
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 0.1) { [weak self] in
              guard let strongSelf = self else { return }

              let barscoreLabelOriginX = strongSelf.barscore.frame.origin.x
              let barscoreLabelHeight = strongSelf.barscore.frame.height * 1.1
              let barscoreLabelWidth = barscoreLabelHeight
              strongSelf.barscoreLabel.cornerRadius = barscoreLabelWidth / 2
              strongSelf.barscoreLabel.frame =
                  CGRect(x: barscoreLabelOriginX + strongSelf.barscore.frame.width * barscorePercentage,
                         y: strongSelf.barscore.frame.origin.y - barscoreLabelHeight * 0.05,
                         width: barscoreLabelWidth,
                         height: barscoreLabelHeight)
            }
        }

        // The barscoreView contraints are NOT laid out when cell is first allocated, so need to reload it
        if (hasReloaded < 2) {
            hasReloaded += 1
            delegate.chatTableView.reloadData()
        }
    }

}
