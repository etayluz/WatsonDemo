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
    @IBOutlet weak var buttonsCollectionView: CustomCollectionView!
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

        reloadCell()
    }

    /// The cell is reloaded to allow the buttonsCollectionView to set its intrinsic content size
    /// according to its content view which is only available after the first time it has been loaded
    private func reloadCell() {
        let when = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: when) {
            if let indexPath = self.chatViewController?.chatTableView.indexPath(for: self) {
                self.chatViewController?.chatTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }

    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }

        if let _ = message.options {
            buttonsCollectionView.collectionViewLayout.invalidateLayout()
            buttonsCollectionView.reloadData()
            buttonsCollectionView.isHidden = false
            messageBackground.isHidden = true
            messageLabel.isHidden = true
            rightTriangleView.isHidden = true
            userIcon.isHidden = true
        } else {
            buttonsCollectionView.isHidden = true
            messageBackground.isHidden = false
            messageLabel.isHidden = false
            rightTriangleView.isHidden = false
            userIcon.isHidden = false
        }
    }

    // MARK: - Actions
    func optionButtonTapped(withSelectedButton selectedButton: CustomButton) {

        message?.options = nil
        message?.text = selectedButton.titleLabel?.text

        /// Update message
        if let indexPath = chatViewController?.chatTableView.indexPath(for: self),
           let message = message {
            chatViewController?.messages[indexPath.row] = message
            chatViewController?.dismissKeyboard()
        }

        userIcon.isHidden = false
        buttonsCollectionView.isHidden = true

        let copiedButton = CustomButton(frame: selectedButton.convert(selectedButton.frame, to: self))
        copiedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        copiedButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        copiedButton.backgroundColor = UIColor.white
        copiedButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if let selectedButtonText = selectedButton.titleLabel?.text {
            copiedButton.setTitle(selectedButtonText, for: .normal)
            copiedButton.setTitle(selectedButtonText, for: .highlighted)
        }
        copiedButton.cornerRadius = selectedButton.cornerRadius
        self.addSubview(copiedButton)

        layoutIfNeeded()

        copiedButton.translatesAutoresizingMaskIntoConstraints = false
        copiedButton.trailingAnchor.constraint(equalTo: userIcon.leadingAnchor, constant: -15).isActive = true
        copiedButton.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor).isActive = true


        UIView.animate(withDuration: 0.5, delay: 0.1, animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: { result in
            self.reloadCell()
            copiedButton.removeFromSuperview()
            self.chatViewController?.conversationService.sendMessage(withText: (copiedButton.titleLabel?.text!)!)
        })
    }

}

  // MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension UserChatViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return message?.options?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let optionButtonCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionButtonCell.self),
                                               for: indexPath)  as! OptionButtonCell

        if let option = message?.options?[indexPath.row] {
            optionButtonCell.configure(withOption: option)
            optionButtonCell.userChatViewCell = self
        }

        return optionButtonCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }
}
