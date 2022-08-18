//
//  PlaySound.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String, loop: Bool) {
    let path = Bundle.main.path(forResource: sound, ofType: type)!
    let url = URL(fileURLWithPath: path)

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        if (loop) {
            audioPlayer?.numberOfLoops = -1
        }
        audioPlayer?.play()
    } catch {
        print("ERROR: Could not find and play the sound file!")
    }
}
