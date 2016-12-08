
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

    // MARK: - Init
    init(delegate: SpeechToTextServiceDelegate) {
        self.delegate = delegate
    }


    /// Synthesize speech with given text
    ///
    /// - Parameter text: Text to be syntheszied to speech
    func transcribeSpeechToText(forAudioData audioData: Data) {
        let speechToText = SpeechToText(username: GlobalConstants.dennisNotoBluemixUsernameSTT,
                                        password: GlobalConstants.dennisNotoBluemixPasswordSTT)

        var settings = RecognitionSettings(contentType: .wav)
        settings.smartFormatting = true

        let failure = { (error: Error) in
            print(error)
        }

        speechToText.recognize(audio: audioData, settings: settings, failure: failure) { results in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }

                strongSelf.delegate?.didFinishTranscribingSpeech(withText: results.bestTranscript)
            }
        }
    }

}
