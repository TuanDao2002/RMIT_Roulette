//
//  PlaySound.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import AVFoundation
import SwiftUI

var audioPlayer: AVAudioPlayer?
var arrayOfPlayers = [AVAudioPlayer]()

func playSound(sound: String, type: String, loop: Bool) {
    let path = Bundle.main.path(forResource: sound, ofType: type)!
    let url = URL(fileURLWithPath: path)

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        if (loop) {
            audioPlayer?.numberOfLoops = -1
            if (arrayOfPlayers.count > 0) {
                arrayOfPlayers[0] = audioPlayer!
            } else {
                arrayOfPlayers.append(audioPlayer!)
            }
            audioPlayer?.setVolume(0.2, fadeDuration: 0.5)
            arrayOfPlayers.last?.prepareToPlay()
            arrayOfPlayers.last?.play()
            return
        }
        
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try AVAudioSession.sharedInstance().setActive(true)
        
        arrayOfPlayers.append(audioPlayer!)
        arrayOfPlayers.last?.prepareToPlay()
        arrayOfPlayers.last?.play()
    } catch {
        print("ERROR: Could not find and play the sound file!")
    }
}

func emptySound() {
    for player in arrayOfPlayers {
        player.stop()
    }
    
    arrayOfPlayers.removeAll()
}
