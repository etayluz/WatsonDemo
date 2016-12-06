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
    @IBOutlet weak var chatTableBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: ChatTextField!
    @IBOutlet weak var headerView: UIView!
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
        #if WESTFIELD
            headerView.backgroundColor = UIColor.westfieldHeaderColor()
        #endif
        chatTextField.chatViewController = self

        chatTableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 140

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
        chatTableBottomConstraint.constant = 0
        view.endEditing(true)
    }

    func appendChat(withMessage message: Message) {
        guard let text = message.text,
            (text.characters.count > 0 || message.options != nil || message.mapUrl != nil)
            else { return }


        if message.type == MessageType.User && text.characters.count > 0 {
            conversationService.sendMessage(withText: text)
        }

        if let _ = messages.last?.options {
            /// If user speak or types instead of tapping option button, reload that cell
            let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath
            messages[messages.count - 1] = message
            chatTableView.reloadRows(at: [indexPath], with: .none)
        } else {
            messages.append(message)
            /// Add new row to chatTableView
            let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath
            chatTableView.beginUpdates()
            chatTableView.insertRows(at: [indexPath], with: .none)
            chatTableView.endUpdates()
            let when = DispatchTime.now()
            DispatchQueue.main.asyncAfter(deadline: when + 0.1) {
                self.scrollChatTableToBottom()
            }
        }

    }

    func scrollChatTableToBottom() {
        guard self.messages.count > 0 else { return }

        let indexPath = NSIndexPath(row: self.messages.count - 1, section: 0) as IndexPath
        chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if DEBUG

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

        switch message.type {
        case MessageType.Map:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MapViewCell.self),
                                                     for: indexPath) as! MapViewCell
            cell.configure(withMessage: message)
            return cell

        case MessageType.Watson:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WatsonChatViewCell.self),
                                                     for: indexPath) as! WatsonChatViewCell
            cell.configure(withMessage: message)
            return cell

        case MessageType.User:
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.row]

        if message.type == MessageType.Map {
            return 240
        }
        
        return UITableViewAutomaticDimension
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
        #if !DEBUG
            audioPlayer.play()
        #endif
    }
    
}

// MARK: - ConversationServiceDelegate
extension ChatViewController: ConversationServiceDelegate {
    
    internal func didReceiveMessage(withText text: String, options: [String]?) {
        guard text.characters.count > 0 else { return }

        self.textToSpeechService.synthesizeSpeech(withText: text)
        self.appendChat(withMessage: Message(type: MessageType.Watson, text: text, options: nil))
        if let _ = options {
            self.appendChat(withMessage: Message(type: MessageType.User, text: "", options: options))
        }

    }

    internal func didReceiveMap(withUrl mapUrl: URL) {
        var message = Message(type: MessageType.Map, text: "", options: nil)
        message.mapUrl = mapUrl
        self.appendChat(withMessage: message)
    }

}

// MARK: - RecorderDelegate
extension ChatViewController: RecorderDelegate {

    func finishedRecording(withAudioData audioData: Data) {
        speechToTextService.transcribeSpeechToText(forAudioData: audioData)
    }
    
}
