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
            let indexPath = (self.superview!.superview as! UITableView).indexPath(for: self)! as NSIndexPath
            self.chatViewController?.chatTableView.reloadRows(at: [indexPath as IndexPath], with: .none)
        }
    }

    override func prepareForReuse() {
//        messageBackground.isHidden = false
//        messageLabel.isHidden = false
//        rightTriangleView.isHidden = false
//        userIcon.isHidden = false
//        buttonsCollectionView.reloadData()
    }

    /// Configure user chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message
//        prepareForReuse()

        if let text = message.text,
            text.characters.count > 0 {
            messageLabel.text = text
        }

        if let _ = message.options {
            messageBackground.isHidden = true
            messageLabel.isHidden = true
            rightTriangleView.isHidden = true
            userIcon.isHidden = true
        } else {
            buttonsCollectionView.removeFromSuperview()
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
//            chatViewController?.conversationService.sendMessage(withText: message.text!)
            chatViewController?.dismissKeyboard()
        }

        /// Hide all buttons except for selected button

        userIcon.isHidden = false

        selectedButton.frame = selectedButton.convert(selectedButton.frame, to: self)

        self.addSubview(selectedButton)



        /// Show selected button and change its background color to white
//        selectedButton.isHidden = false
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        selectedButton.backgroundColor = UIColor.white

        buttonsCollectionView.removeFromSuperview()

        selectedButton.trailingAnchor.constraint(equalTo: userIcon.leadingAnchor, constant: -15).isActive = true
        selectedButton.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor).isActive = true

        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.layoutIfNeeded()
        }, completion: { result in

           self.reloadCell()
//            selectedButton.isHidden = true
//            self.messageLabel.text = selectedButton.titleLabel?.text
//            self.prepareForReuse()
        })

//        UIView.animate(withDuration: 1) { [weak self] in
//            self?.layoutIfNeeded()
//        }, completion: { result in
//
//        })
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
            optionButtonCell.userChatViewCell = self
        }

        return optionButtonCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }
}

