
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
    func textToSpeechDidFinishSynthesizing(withAudioData audioData: NSData)
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
        let textToSpeech = TextToSpeech(username: GlobalConstants.username, password: GlobalConstants.password)
        let failure = { (error: Error) in print(error) }
        textToSpeech.synthesize(text, failure: failure) { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data as NSData)
        }
    }

}
