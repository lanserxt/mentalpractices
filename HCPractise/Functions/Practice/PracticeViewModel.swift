//
//  PracticeViewModel.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import Foundation
import AVKit
import AVFoundation

final class PracticeViewModel {
    /// Audio player
    private(set) var audioPlayer: AVPlayer?
    private(set) var isPaused: Bool = false
    
    func prepareAudioSession(_ url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
    }
    
    //Media actions    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        guard let audioPlayer = audioPlayer else {return}
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            isPaused = true
        } else {
            isPaused = false
        }
    }
    
    func restart() {
        guard let audioPlayer = audioPlayer else {return}
        
        if audioPlayer.isPlaying || isPaused{
            audioPlayer.pause()
            audioPlayer.seek(to: CMTime.zero)
            
            audioPlayer.play()
        } else {
            audioPlayer.play()
        }
    }
}
