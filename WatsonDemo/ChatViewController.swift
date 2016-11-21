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
        static let conversationKickoffMessage = "Hi"
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
    lazy var conversationService: ConversationService = ConversationService(delegate:self)
    lazy var recorderService: RecorderService = RecorderService(delegate: self)
    lazy var speechToTextService: SpeechToTextService = SpeechToTextService(delegate:self)
    lazy var textToSpeechService: TextToSpeechService = TextToSpeechService(delegate:self)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()
        chatTextField.chatViewController = self
        chatTableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;

        // We need to send some dummy text to keep off the conversation
        conversationService.sendMessage(withText: Constants.conversationKickoffMessage)

        let gestureTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        chatTableView.addGestureRecognizer(gestureTap)
    }

    // MARK: - Actions
    @IBAction func micButtonTapped() {
        if micButton.isSelected {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOff")
            recorderService.finishRecording(success: true)
        } else {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOn")
            audioPlayer.stop()
            recorderService.startRecording()
        }

        micButton.isSelected = !micButton.isSelected
    }


    /// Dismiss keyboard on screen tap
    func dismissKeyboard() {
        view.endEditing(true)
    }

//    func appendMessageToChat(withMessageType messageType: MessageType, text: String) {
    func appendChat(withMessage message: Message) {
        guard let text = message.text, (text.characters.count > 0 || message.options != nil) else { return }

        if message.type == MessageType.User && text.characters.count > 0 {
            conversationService.sendMessage(withText: text)
        }

        if messages.last?.options != nil {
            let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath
            messages[messages.count - 1] = message
            chatTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        } else {
            messages.append(message)
            /// Add new row to chatTableView
            let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath
            chatTableView.beginUpdates()
            chatTableView.insertRows(at: [indexPath], with: .automatic)
            chatTableView.endUpdates()
            chatTableView.scrollToRow(at: indexPath,
                                      at: UITableViewScrollPosition.bottom,
                                      animated: true)
        }

    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
//            chatTableView.reloadData()
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
            cell.chatViewController = self
            return cell
        }

    }

}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDelegate {

    private struct ChatTableView {
        static let cellRowHeight: CGFloat = 120
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ChatTableView.cellRowHeight
    }
    
}

// MARK: - SpeechToTextServiceDelegate
extension ChatViewController: SpeechToTextServiceDelegate {

    func didFinishTranscribingSpeech(withText text: String) {
        appendChat(withMessage: Message(type: MessageType.User, text: text, options: nil))
    }
    
}

// MARK: - TextToSpeechServiceDelegate
extension ChatViewController: TextToSpeechServiceDelegate {

    func textToSpeechDidFinishSynthesizing(withAudioData audioData: Data) {
        audioPlayer = try! AVAudioPlayer(data: audioData)
        audioPlayer.play()
    }
    
}

// MARK: - ConversationServiceDelegate
extension ChatViewController: ConversationServiceDelegate {
    
    internal func didReceiveMessage(withText text: String, options: [String]?) {
        guard text.characters.count > 0 else { return }

        textToSpeechService.synthesizeSpeech(withText: text)
        appendChat(withMessage: Message(type: MessageType.Watson, text: text, options: nil))
        if let _ = options {
            appendChat(withMessage: Message(type: MessageType.User, text: "", options: options))
        }
    }

}

// MARK: - RecorderDelegate
extension ChatViewController: RecorderDelegate {

    func finishedRecording(withAudioData audioData: Data) {
        speechToTextService.transcribeSpeechToText(forAudioData: audioData)
    }
    
}
