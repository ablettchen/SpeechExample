//
//  SpeechPermission.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import Foundation
import Speech
import AVFoundation

public struct SpeechPermission: PermissionInterface {
    
    var isAuthorized: Bool {
        return SFSpeechRecognizer.authorizationStatus() == .authorized
    }
    
    var isDenied: Bool {
        return SFSpeechRecognizer.authorizationStatus() == .denied
    }
    
    func request(withCompletionHandler сompletionHandler: @escaping ()->()?) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                сompletionHandler()
            }
        }
    }
}

struct MicrophonePermission: PermissionInterface {
    
    var isAuthorized: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
    
    var isDenied: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .denied
    }
    
    func request(withCompletionHandler сompletionHandler: @escaping ()->()?) {
        AVAudioSession.sharedInstance().requestRecordPermission {
            granted in
            DispatchQueue.main.async {
                сompletionHandler()
            }
        }
    }
}

private protocol PermissionInterface {
    var isAuthorized: Bool { get }
    var isDenied: Bool { get }
    func request(withCompletionHandler сompletionHandler: @escaping ()->()?)
}

