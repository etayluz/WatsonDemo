//
//  TextToSpeechService.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

import AVFoundation
import TextToSpeechV1

protocol TextToSpeechServiceDelegate: class {
    func textToSpeechDidFinishSynthesizing(withAudioData audioData: Data)
}

class TextToSpeechService {

    // MARK: - Properties
    weak var delegate: TextToSpeechServiceDelegate?

    // MARK: - Init
    init(delegate: TextToSpeechServiceDelegate) {
        self.delegate = delegate
    }

    /// Synthesize speech with given text
    ///
    /// - Parameter text: Text to be syntheszied to speech
    func synthesizeSpeech(withText text: String) {
        guard text.count > 0 else { return }
        
        let textToSpeech = TextToSpeech(username: GlobalConstants.BluemixUsernameTTS,
                                        password: GlobalConstants.BluemixPasswordTTS)

        let failure = { (error: Error) in
            print("synthesizeSpeech failed");
            print(error)
        }

//        let voice = "us_Michael.rawValue"
        let accept = "audio/wav"
        if GlobalConstants.STTcustomizationID == "" {
            textToSpeech.synthesize(text: text, accept: accept, failure: failure) { data in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data)
                }
            }

         }
        else {
            textToSpeech.synthesize(text: text,
                                    accept: accept,
                                    customizationID: GlobalConstants.TTScustomizationID,
                                    failure: failure) { data in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data)
                }
            }
        }
    }

}
