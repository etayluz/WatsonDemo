//
//  AppDelegate.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import AVFoundation
import UIKit
import Fabric
import Crashlytics
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])
        setupAudioPlayback()
        setupIQKeyboardManager()
        return true
    }

    // MARK: - Private
    // Force audio to play even when mute switch is turned on to make the app user-error-proof
    private func setupAudioPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord,
                                                            with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        } catch {
            // no-op
        }
    }


    /// Setup IQKeyboardManager
    private func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true

    }

}

