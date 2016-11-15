//
//  ChatViewController.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
    }

    // MARK: - Outlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: ChatTextField!

    // MARK: - Properties
    var messages = [Message]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()
        chatTextField.chatViewController = self
    }

    // MARK: - Actions
    @IBAction func dismissKeyboardButtonTapped() {
        view.endEditing(true)
    }

    func addUserChat(withMessage message: String) {
        guard message.characters.count > 0 else { return }

//        let indexes: IndexSet = [1]
//
//        chatTableView.beginUpdates()
//        chatTableView.insertSections(indexes, with: UITableViewRowAnimation)
//        chatTableView.endUpdates()
    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            messages.append(Message(type: MessageType.Watson, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything?"))
            messages.append(Message(type: MessageType.User, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything? test e ad asdf adf asdfads fads fas falsdfklads fkj l;adfj lajkfl; adjfl;adjs "))
            chatTableView.reloadData()
        #endif
    }

}
// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {

//    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 5// messages.count
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.type == MessageType.Watson {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatsonChatViewCell.self),
                                                     for: indexPath) as! WatsonChatViewCell
            cell.configure(withMessage: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserChatViewCell.self),
                                                     for: indexPath) as! UserChatViewCell
            cell.configure(withMessage: message)
            return cell
        }

    }

}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDelegate {

    private struct AlertTableView {
        static let dictationIssueAlertCellRowHeight: CGFloat = 120
        static let signOffAlertCellRowHeight: CGFloat = 143.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AlertTableView.dictationIssueAlertCellRowHeight
    }
    
}

