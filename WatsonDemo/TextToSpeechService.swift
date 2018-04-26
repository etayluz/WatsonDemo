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

        #if WATSONBANKASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONINSASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONWEALTHASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONWEALTHTASST  || DEBUG
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONASST
            ////let voice  =  SynthesisVoice.us_Lisa.rawValue
            let voice  =  SynthesisVoice.gb_Kate.rawValue
        #elseif WATSONMETASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONWHIRLASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONFIDASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONALFASST || DEBUG
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONREGASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONFMAEASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #elseif WATSONHERTZASST
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #else
            let voice  =  SynthesisVoice.us_Michael.rawValue
        #endif
        
        
        
        let textToSpeech = TextToSpeech(username: GlobalConstants.BluemixUsernameTTS,
                                        password: GlobalConstants.BluemixPasswordTTS)

        let failure = { (error: Error) in
            print("synthesizeSpeech failed");
            print(error)
        }

<<<<<<< HEAD
//        let voice = "us_Michael.rawValue"
        let accept = "audio/wav"
        if GlobalConstants.STTcustomizationID == "" {
            textToSpeech.synthesize(text: text, accept: accept, failure: failure) { data in
=======
         if GlobalConstants.STTcustomizationID == "" {
            textToSpeech.synthesize(text, voice: voice, audioFormat: AudioFormat.wav, failure: failure) { data in
>>>>>>> parent of 5c20a8b... Save work
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data)
                }
            }

         }
        else {
<<<<<<< HEAD
            textToSpeech.synthesize(text: text,
                                    accept: accept,
                                    customizationID: GlobalConstants.TTScustomizationID,
=======
            textToSpeech.synthesize(text,voice: voice, customizationID: GlobalConstants.TTScustomizationID,
                                    audioFormat: AudioFormat.wav,
>>>>>>> parent of 5c20a8b... Save work
                                    failure: failure) { data in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.delegate?.textToSpeechDidFinishSynthesizing(withAudioData: data)
                }
            }
        }
    }

}
