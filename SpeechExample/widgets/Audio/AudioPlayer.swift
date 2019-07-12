//
//  AudioPlayer.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/12.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import AVFoundation

public class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    public var isPlaying: Bool {
        get {
            return self.player?.isPlaying ?? false
        }
    }

    fileprivate var player: AVAudioPlayer?
    fileprivate var endPlayingComplection: (()->())? = nil
    
    public func play(fileName: String, complection: (()->())? = nil) {
        self.endPlayingComplection?()
        self.player = AVAudioPlayer()
        let url = Bundle.main.url(forResource: fileName, withExtension: nil)
        if url == nil {
            self.endPlayingComplection?()
            return
        }
        do {
            self.player = try AVAudioPlayer(contentsOf: url!)
            player!.volume = 1
            player!.delegate = self
            player!.prepareToPlay()
            player!.play()
            self.endPlayingComplection = complection
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.endPlayingComplection?()
    }
}
