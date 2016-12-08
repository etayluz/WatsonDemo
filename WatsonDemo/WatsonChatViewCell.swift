//
//  WatsonChatViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import TTTAttributedLabel
import UIKit

class WatsonChatViewCell: UITableViewCell {

    // MARK: - Doc
    private struct Doc {
        static let employerPolicy = "https://drive.google.com/file/d/0B-UVZVvBHs8uUjJiSXJlS2NXRGxOd3YtX1cxbExhYXhfUXlz/view?usp=sharing"
        static let driverTraining = "https://drive.google.com/file/d/0B-UVZVvBHs8uQ1puaXhBYS11SFdfUHZEWXZqSFN2T29xSmMw/view?usp=sharing"
        static let vehicleInspection = "https://drive.google.com/file/d/0B-UVZVvBHs8ueVVDOHkza2hKNVNyanNZSXFUTkFpZldnSEdR/view?usp=sharing"
        static let fleetProgram = "https://drive.google.com/file/d/0B-UVZVvBHs8uRjUySlZLYS1mYTdqU3FzbkNvVzlJaTBfajBV/view?usp=sharing"
    }

    // MARK: - Outlets

    @IBOutlet weak var messageLabel: TTTAttributedLabel!
    @IBOutlet weak var watsonIcon: UIImageView!

    /// Configure Watson chat table view cell with Watson message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        messageLabel.text = message.text

        setupHyperLinks()
    }

    private func setupHyperLinks() {
        guard var text = messageLabel.text  else { return }

        messageLabel.delegate = self

        if (text.contains("Please review and apply the ideas on this outline to set up a Preventative Maintenance program.")) {
            text.append(" 1. Fleet  program, 2. Vehicle Inspection.")
            messageLabel.text = text
            let nsText = text as NSString
            let range1: NSRange = nsText.range(of: "Fleet  program")
            messageLabel.addLink(to: URL(string: Doc.fleetProgram) , with: range1)

            let range2: NSRange = nsText.range(of: "Vehicle Inspection")
            messageLabel.addLink(to: URL(string: Doc.vehicleInspection) , with: range2)
        }

        if (text.contains("I would suggest starting with the basics")) {
            text.append(" 1. Sample employer policy, 2. Driver training DD")
            messageLabel.text = text
            let nsText = text as NSString
            let range1: NSRange = nsText.range(of: "Sample employer policy")
            messageLabel.addLink(to: URL(string: Doc.employerPolicy) , with: range1)

            let range2: NSRange = nsText.range(of: "Driver training DD")
            messageLabel.addLink(to: URL(string: Doc.driverTraining) , with: range2)
        }

    }

}

// MARK: - ConversationServiceDelegate
extension WatsonChatViewCell: TTTAttributedLabelDelegate {

    public func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.openURL(url)
    }
    
}
