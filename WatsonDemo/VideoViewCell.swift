//
//  VideoChatViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 12/7/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import MediaPlayer
import AVKit

class VideoViewCell: UITableViewCell {

    // MARK: - Outlets


    // MARK: - Properties
    var playerViewController: AVPlayerViewController!
    var chatViewController: ChatViewController?
    var message: Message?

    // MARK: - VideoUrl
    var videoUrls = [URL]()

    // MARK: - Cell Lifecycle
    override func prepareForReuse() {
        NotificationCenter.default.removeObserver(self)
    }

    /// Configure video chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        self.message = message


        let player = AVPlayer(url: message.videoUrl!)

        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        #if DEBUG
            playerViewController.player?.volume = 0
        #endif
    
        playerViewController.view.frame = CGRect(x: 20,
                                                 y: 0,
                                                 width: frame.size.width - 40,
                                                 height: frame.size.height - 35)
        self.addSubview(playerViewController.view)

        if videoUrls.contains(message.videoUrl!) == false {
          //  playerViewController.player?.play()
            videoUrls.append(message.videoUrl!)
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(VideoViewCell.playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)


//        let player = AVPlayer(url: message.videoUrl!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.bounds
//        layer.addSublayer(playerLayer)
//        player.play()
//        #if DEBUG
//            player.volume = 0
//        #endif
    }

    func playerDidFinishPlaying() {
        if chatViewController?.messages.last?.type == message?.type {
          //  chatViewController?.conversationService.sendMessage(withText: "OK")
        }
    }

}
