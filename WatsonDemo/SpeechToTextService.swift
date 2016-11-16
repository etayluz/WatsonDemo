
//
//  SpeechToTextService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

import AVFoundation
import SpeechToTextV1

protocol SpeechToTextServiceDelegate: class {
    func didFinishTranscribingSpeech(withText text: String)
}

class SpeechToTextService {

    // MARK: - Properties
    weak var delegate: SpeechToTextServiceDelegate?
    let speechToTextSession = SpeechToTextSession(username: GlobalConstants.dennisNotoBluemixUsername,
                                                  password: GlobalConstants.dennisNotoBluemixPassword)

    // MARK: - Init
    init(delegate: SpeechToTextServiceDelegate) {
        self.delegate = delegate
    }


    /// Stream audio
    func startStreaming() {
        // define callbacks
        speechToTextSession.onConnect = { print("connected") }
        speechToTextSession.onDisconnect = { print("disconnected") }
        speechToTextSession.onError = { error in print(error) }
        speechToTextSession.onPowerData = { decibels in print(decibels) }
        speechToTextSession.onMicrophoneData = { data in print("received data") }
        speechToTextSession.onResults = { results in print(results.bestTranscript) }

        // define recognition request settings
        var settings = RecognitionSettings(contentType: .opus)
        settings.interimResults = true
        settings.continuous = true

        // start streaming microphone audio for transcription
        speechToTextSession.connect()
        speechToTextSession.startRequest(settings: settings)
        speechToTextSession.startMicrophone()
    }


    /// Stop streaming audio
    func stopStreaming() {
        speechToTextSession.stopMicrophone()
        speechToTextSession.stopRequest()
        speechToTextSession.disconnect()
    }

    /// Synthesize speech with given text
    ///
    /// - Parameter text: Text to be syntheszied to speech
//    func transcribeSpeechToText(forAudioData audioData: Data) {
//        let speechToText = SpeechToText(username: GlobalConstants.dennisNotoBluemixUsername,
//                                        password: GlobalConstants.dennisNotoBluemixPassword)
//
//        var settings = RecognitionSettings(contentType: .wav)
//        settings.interimResults = true
//
//        let failure = {
//            (error: Error) in print(error)
//        }
//
//        speechToText.recognize(audio: audioData, settings: settings, failure: failure) { results in
//            print(results)
//        }
//    }

}
