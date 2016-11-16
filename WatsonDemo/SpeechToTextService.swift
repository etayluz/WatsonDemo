
//
//  SpeechToTextService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

import AVFoundation
import TextToSpeechV1

protocol SpeechToTextServiceDelegate: class {
    func textToSpeechDidFinishSynthesizing(withAudioData audioData: Data)
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
    func synthesizeSpeech(withText text: String) {
        let textToSpeech = TextToSpeech(username: GlobalConstants.etayluzBluemixUsername,
                                        password: GlobalConstants.etayluzBluemixPassword)
        let failure = { (error: Error) in
            print(error)
        }

        textToSpeech.synthesize(text, audioFormat: AudioFormat.wav, failure: failure) { data in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }

                strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data)
            }
        }
    }

}
