
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
    var delegate: SpeechToTextServiceDelegate?
    var speechToTextSession: SpeechToTextSession? = nil
    var textTranscription: String?


    // MARK: - Init
    init(delegate: SpeechToTextServiceDelegate) {
        self.delegate = delegate

        if GlobalConstants.STTcustomizationID == "" {
             speechToTextSession = SpeechToTextSession(username: GlobalConstants.BluemixUsernameSTT,
                                                       password: GlobalConstants.BluemixPasswordSTT)
        }
        else {
            speechToTextSession = SpeechToTextSession(username: GlobalConstants.BluemixUsernameSTT,
                                                      password: GlobalConstants.BluemixPasswordSTT,
                                                      languageCustomizationID: GlobalConstants.STTcustomizationID,
                                                      acousticCustomizationID: GlobalConstants.STTcustomizationID)
        }

        speechToTextSession?.onResults =
            { results in print(results)
//                if let bestTranscript = results.bestTranscript as String? {
//                    if bestTranscript.count > 0 {
//                        let truncated = bestTranscript.substring(to: bestTranscript.index(before: bestTranscript.endIndex))
//                        delegate.didFinishTranscribingSpeech(withText: truncated)
//                    }
//                }
            }
    }


    /// Start recording session
    func startRecording() {
//        var settings = RecognitionSettings(contentType: .opus)
        var settings = RecognitionSettings(contentType: nil)
        settings.interimResults = false
//        settings.continuous = true
        settings.inactivityTimeout = -1
        settings.smartFormatting = true
        speechToTextSession?.connect()
        speechToTextSession?.startRequest(settings: settings)
        speechToTextSession?.startMicrophone()
    }


    /// Finish recording session
    func finishRecording() {
        speechToTextSession?.stopMicrophone()
        speechToTextSession?.stopRequest()
        speechToTextSession?.disconnect()
    }
    
}
