//
//  Recorder.swift
//
//  Created by Etay Luz on 8/15/16.
//

import AVFoundation
import UIKit


protocol RecorderDelegate: class {
    func finishedRecording(withAudioData audioData: Data)
}

public class RecorderService: NSObject, AVAudioRecorderDelegate {

    lazy var audioURL: URL = RecorderService.directoryURL()
    var audioRecorder: AVAudioRecorder!
    var recordingSession: AVAudioSession!
    weak var delegate: RecorderDelegate?

    override init() {
        super.init()

        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { (allowed: Bool) -> Void in
                DispatchQueue.main.async {
                    if allowed {
                        // success
                    } else {
                      print("Did not receive permission to record")
                        // TBD: Show a message to the user that they need to give permission in settings app to proceed
                        // ------- This should happen automatically -- if you are using a device other than the Simulator
                    }
                }
            }
        } catch {
            // TBD: Show a message to the user that they need to give permission in settings app to proceed
        }
    }

    // MARK: - Convenience Init
    convenience init(delegate: RecorderDelegate) {
        self.init()
        self.delegate = delegate
    }

    func startRecording() {

        let settings = [AVFormatIDKey: NSNumber(value: Int32(kAudioFormatLinearPCM)),
                        AVSampleRateKey: NSNumber(value: Float(16000.0)),
                        AVNumberOfChannelsKey: NSNumber(value: 1),
                        AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.high.rawValue))]


        do {
            try audioRecorder = AVAudioRecorder(url: audioURL as URL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

        } catch (let error) {
            print("Failed to record with error: \(error)")
            finishRecording(success: false)
        }
    }

    func finishRecording(success: Bool) {
        guard let _ = audioRecorder else { return }

        audioRecorder.stop()
        audioRecorder = nil

        if success {
           // Copy recording from disk into program memory and delete recording from disk
            let audioData = FileManager.default.contents(atPath: audioURL.path)!
            do {
              try FileManager.default.removeItem(at: audioURL as URL)
                delegate?.finishedRecording(withAudioData: audioData)
            } catch {
              finishRecording(success: false)
            }
        } else {
            // Handle recording failure
        }
    }

    class func directoryURL() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("sound.wav")
        return soundURL!
    }
}
