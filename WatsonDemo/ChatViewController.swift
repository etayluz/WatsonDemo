//
//  ChatViewController.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import AVFoundation
import UIKit

class ChatViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
    }

    // MARK: - Outlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: ChatTextField!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var micImage: UIImageView!

    // MARK: - Properties
    var audioPlayer = AVAudioPlayer()
    var messages = [Message]()


    // MARK: - Services
    private lazy var conversationService: ConversationService = ConversationService(delegate:self)
    private lazy var textToSpeechService: TextToSpeechService = TextToSpeechService(delegate:self)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()
        chatTextField.chatViewController = self
        chatTableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;

        conversationService.sendMessage(withText: "Hi")

        let gestureTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        chatTableView.addGestureRecognizer(gestureTap)
    }

    // MARK: - Actions
    @IBAction func micButtonTapped() {
        if micButton.isSelected {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOff")
        } else {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOn")
        }

        micButton.isSelected = !micButton.isSelected
    }


    /// Dismiss keyboard on screen tap
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func addUserChat(withMessage message: String) {
        guard message.characters.count > 0 else { return }

        messages.append(Message(type: MessageType.User, text: message))
        addNewMessageToChat()
        textToSpeechService.synthesizeSpeech(withText: message)
    }

    private func addNewMessageToChat() {
        let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath

        chatTableView.beginUpdates()
        chatTableView.insertRows(at: [indexPath], with: .automatic)
        chatTableView.endUpdates()
        chatTableView.scrollToRow(at: indexPath,
                                  at: UITableViewScrollPosition.bottom,
                                  animated: true)
    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            messages.append(Message(type: MessageType.Watson, text: "Hello! I'm your personal banking virtual assistant. You can ask me about anything?"))
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
    
}

// MARK: - TextToSpeechServiceDelegate
extension ChatViewController: TextToSpeechServiceDelegate {

    func textToSpeechDidFinishSynthesizing(withAudioData audioData: Data) {
        audioPlayer = try! AVAudioPlayer(data: audioData)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
}

// MARK: - ConversationServiceDelegate
extension ChatViewController: ConversationServiceDelegate {

    func didReceiveMessage(withText:String) {

    }

}
