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

    /// Configure video chat table view cell with user message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        let player = AVPlayer(url: message.videoUrl!)

        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        #if DEBUG
            playerViewController.player?.volume = 0
        #endif
        playerViewController.view.frame = bounds
        self.addSubview(playerViewController.view)

        playerViewController.player?.play()

        // TBD:
        // Terminating app due to uncaught exception 'NSInvalidArgumentException',
        // reason: '-[WatsonDemo.VideoViewCell playerDidFinishPlaying:]: 
        // unrecognized selector sent to instance 0x7f906d938a00
//        NotificationCenter.default.addObserver(self,
//                                               selector: Selector(("playerDidFinishPlaying:")),
//                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
//                                               object: player.currentItem)


//        let player = AVPlayer(url: message.videoUrl!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.bounds
//        layer.addSublayer(playerLayer)
//        player.play()
//        #if DEBUG
//            player.volume = 0
//        #endif
    }

//    func playerDidFinishPlaying(note: NSNotification) {
//        chatViewController?.conversationService.sendMessage(withText: "OK")
//    }

}
