//
//  ChatViewController.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import AVFoundation
import UIKit
import Darwin

class ChatViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
      
    static let defaultConversationKickoffMessage = "Hi"
    
    }

    // MARK: - Outlets
    @IBOutlet weak var chatTableBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextField: ChatTextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var micImage: UIImageView!

    // MARK: - Properties
    var audioPlayer: AVAudioPlayer?
    var messages = [Message]()
    var kickoffMessage = Constants.defaultConversationKickoffMessage
    var firstTime = true

    // MARK: - Services
    lazy var conversationService: ConversationService = ConversationService(delegate:self)
    lazy var speechToTextService: SpeechToTextService = SpeechToTextService(delegate:self)
    lazy var textToSpeechService: TextToSpeechService = TextToSpeechService(delegate:self)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        #if WATSONBANKASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONINSASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONWEALTHASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONWEALTHTASST  || DEBUG
            headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONASST
            headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONMETASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONWHIRLASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONFIDASST
            headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONALFASST || DEBUG
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONREGASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
        #elseif WATSONFMAEASST
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #elseif WATSONHERTZASST
            headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x000000)
        #else
             headerView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
        #endif
        
    
        setupSimulator()
        chatTextField.chatViewController = self
    
        chatTableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 140

        // We need to send some dummy text to kick off the conversation
        NSLog(kickoffMessage)
        conversationService.sendMessage(withText: kickoffMessage)

        let gestureTap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        gestureTap.cancelsTouchesInView = false
        chatTableView.addGestureRecognizer(gestureTap)

        // This is a temporary patch for a bug where SpeechToTextSession doesn't work (but only the first time around)
        speechToTextService.startRecording()
        speechToTextService.finishRecording()
    }

    // MARK: - Actions
    @IBAction func micButtonTapped() {
        if micButton.isSelected {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOff")
            speechToTextService.finishRecording()
        } else {
            micImage.image = UIImage.init(imageLiteralResourceName: "MicOn")
            if let _ = audioPlayer {
                audioPlayer?.stop()
            }
            
            speechToTextService.startRecording()
        }

        micButton.isSelected = !micButton.isSelected
    }


    /// Dismiss keyboard on screen tap
    @objc func dismissKeyboard() {
        chatTableBottomConstraint.constant = 0
        view.endEditing(true)
    }

    func appendChat(withMessage message: Message) {
        guard let text = message.text,
            (text.count > 0 || message.options != nil ||
                message.mapStr != nil || message.videoUrl != nil ||
                message.barscore != nil)
            else { return }


        if message.type == MessageType.User && text.count > 0 {
            conversationService.sendMessage(withText: text)
        }

//        if let _ = messages.last?.options {
//            /// If user speak or types instead of tapping option button, reload that cell
//            let indexPath = NSIndexPath(row: messages.count - 1, section: 0) as IndexPath
//            messages[messages.count - 1] = message
//            chatTableView.reloadRows(at: [indexPath], with: .none)
//        } else {
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
//        }

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

        case MessageType.Barscore:
           let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BarscoreViewCell.self),
                                                    for: indexPath) as! BarscoreViewCell
            cell.configure(withMessage: message, delegate: self)
            return cell

        case MessageType.Checkbox:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckboxViewCell.self),
                                                     for: indexPath) as! CheckboxViewCell
            cell.configure(withMessage: message, delegate: self)
            return cell

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

        case MessageType.Video:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoViewCell.self),
                                                     for: indexPath) as! VideoViewCell
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
            return 450
        }

        if message.type == MessageType.Video {
            return UIScreen.main.bounds.size.width * 0.76
        }

        if message.type == MessageType.Checkbox {
            return CGFloat(message.options!.count) * 35 + 150
        }

        if message.type == MessageType.Barscore {
            return 175
        }

        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("here")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("here")
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("here")
//    }

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
//        #if !DEBUG
            audioPlayer?.play()
//        #endif
    }
    
}

// MARK: - ConversationServiceDelegate
extension ChatViewController: ConversationServiceDelegate {
    internal func didReceiveBarscore(withBarscore barscore: String) {
        var message = Message(type: MessageType.Barscore, text: "", options: nil)
        message.barscore = barscore
        self.appendChat(withMessage: message)
    }


    internal func didReceiveMessage(withText text: String, options: [String]?) {
        guard text.count > 0 else { return }
        
        //add code for multiple messages from watson
        let texts = text.components(separatedBy: "\",\"")
        let arraySize = texts.count
        var mycounter = 0
        
        for mytext in texts {
          mycounter = mycounter + 1
          self.appendChat(withMessage: Message(type: MessageType.Watson, text: mytext, options: nil))
          if let _ = options {
            
            if mycounter == arraySize {
                self.appendChat(withMessage: Message(type: MessageType.User, text: "", options: options))}
            else {
                self.appendChat(withMessage: Message(type: MessageType.User, text: "", options: nil))}
            }
        }
        let finalText =  texts.joined(separator: " ")
        self.textToSpeechService.synthesizeSpeech(withText: finalText)
    }

    internal func didReceiveMap(withString mapStr: String) {
        var message = Message(type: MessageType.Map, text: "", options: nil)
        message.mapStr = mapStr
        self.appendChat(withMessage: message)
    }

    internal func didReceiveVideo(withUrl videoUrl: URL) {
        var message = Message(type: MessageType.Video, text: "", options: nil)
        message.videoUrl = videoUrl
        self.appendChat(withMessage: message)
    }

    internal func didReceiveCheckbox(withOptions options: [String]) {
        let message = Message(type: MessageType.Checkbox, text: "", options: options)
        self.appendChat(withMessage: message)
    }

}

// MARK: - CheckboxViewCellDelegate
extension ChatViewController: CheckboxViewCellDelegate {

    func continueButtonTapped(withCheckedOptions checkedOptions: [String]) {
        conversationService.sendMessage(withText: checkedOptions.joined(separator: ", "))
    }

}
