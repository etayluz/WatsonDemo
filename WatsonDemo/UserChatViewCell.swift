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
    @IBOutlet weak var buttonsCollectionView: UICollectionView!
    @IBOutlet weak var buttonsCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightTriangleView: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!


    // MARK: - Constraints
    @IBOutlet weak var buttonsLeadingConstraint: NSLayoutConstraint!

    // MARK: - Properties
    var message: Message?
    var chatViewController: ChatViewController?


    override func awakeFromNib() {
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self

        if let flowLayout = buttonsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }

//        let when = DispatchTime.now() + 2
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            self.buttonsCollectionView.reloadData()
//        }
    }

    override func prepareForReuse() {
        messageBackground.isHidden = false
        messageLabel.isHidden = false
        rightTriangleView.isHidden = false
        userIcon.isHidden = false

    }

    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message
        prepareForReuse()

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }

        if let options = message.options {
            messageBackground.isHidden = true
            messageLabel.isHidden = true
            rightTriangleView.isHidden = true
            userIcon.isHidden = true

            for (index, option) in options.enumerated() {

            }
        } else {
            messageBackground.isHidden = false
            messageLabel.isHidden = false
            rightTriangleView.isHidden = false
            userIcon.isHidden = false
        }
    }

    // MARK: - Actions
    @IBAction func optionButtonTapped(_ sender: CustomButton) {
        let selectedButton = sender

        message?.options = nil
        message?.text = selectedButton.titleLabel?.text

        /// Update message
        if let indexPath = chatViewController?.chatTableView.indexPath(for: self),
           let message = message {
            chatViewController?.messages[indexPath.row] = message
            chatViewController?.conversationService.sendMessage(withText: message.text!)
            chatViewController?.dismissKeyboard()
        }

        /// Hide all buttons except for selected button

        userIcon.isHidden = false

        /// Show selected button and change its background color to white
        selectedButton.isHidden = false
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        selectedButton.backgroundColor = UIColor.white

        UIView.animate(withDuration: 0.5, animations: {
            let constraintOffset = self.userIcon.frame.origin.x - selectedButton.frame.origin.x - selectedButton.frame.size.width - 15
            self.buttonsLeadingConstraint.constant += constraintOffset
            selectedButton.superview?.layoutIfNeeded()
        }, completion: { result in
            selectedButton.isHidden = true
            self.messageLabel.text = selectedButton.titleLabel?.text
            self.prepareForReuse()
        })
    }

}

  // MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension UserChatViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        if let count = message?.options?.count {
            return count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let optionButtonCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "OptionButtonCell", for: indexPath)  as! OptionButtonCell

        if let option = message?.options?[indexPath.row] {
            optionButtonCell.configure(withOption: option)
        }

        return optionButtonCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }
}

