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
        chatTableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;
    }

    // MARK: - Actions
    @IBAction func dismissKeyboardButtonTapped() {
        view.endEditing(true)
    }

    func addUserChat(withMessage message: String) {
        guard message.characters.count > 0 else { return }

        messages.append(Message(type: MessageType.User, text: message))

        chatTableView.beginUpdates()
        chatTableView.insertRows(at: [NSIndexPath(row: messages.count - 1, section: 0) as IndexPath], with: .automatic)
        chatTableView.endUpdates()

        chatTableView.scrollToRow(at: NSIndexPath(row: messages.count - 1, section: 0) as IndexPath,
                                  at: UITableViewScrollPosition.bottom,
                                  animated: true)
    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            messages.append(Message(type: MessageType.Watson, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything?"))
            messages.append(Message(type: MessageType.User, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything? test e"))
            messages.append(Message(type: MessageType.User, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything? test e"))
            messages.append(Message(type: MessageType.User, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything? test e"))
            messages.append(Message(type: MessageType.User, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything? test e"))

            chatTableView.reloadData()
        #endif
    }

}
// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {

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
        static let cellRowHeight: CGFloat = 120
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AlertTableView.cellRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        view.endEditing(true)
    }
    
}

