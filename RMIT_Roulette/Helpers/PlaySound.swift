/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Dao Kha Tuan
  ID: 3877347
  Created  date: 14/08/2022
  Last modified: 27/08/2022
  Acknowledgement: None
*/

import AVFoundation

var audioPlayer: AVAudioPlayer?
var arrayOfPlayers = [AVAudioPlayer]()

// function to play sound effects and background musics
func playSound(sound: String, type: String, loop: Bool) {
    let path = Bundle.main.path(forResource: sound, ofType: type)!
    let url = URL(fileURLWithPath: path)

    // change background music if needed
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        if (loop) {
            audioPlayer?.numberOfLoops = -1
            if (arrayOfPlayers.count > 0) {
                if (arrayOfPlayers[0].url == url) {return}
                arrayOfPlayers[0] = audioPlayer!
            } else {
                arrayOfPlayers.append(audioPlayer!)
            }
            audioPlayer?.setVolume(0.2, fadeDuration: 0.5)
            arrayOfPlayers.last?.prepareToPlay()
            arrayOfPlayers.last?.play()
            return
        }
        
        // can play multiple sounds at once
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try AVAudioSession.sharedInstance().setActive(true)
        
        arrayOfPlayers.append(audioPlayer!)
        arrayOfPlayers.last?.prepareToPlay()
        arrayOfPlayers.last?.play()
    } catch {
        print("ERROR: Could not find and play the sound file!")
    }
}

// empty and stop all sounds to play new sounds
func emptySound() {
    for player in arrayOfPlayers {
        player.stop()
    }
    
    arrayOfPlayers.removeAll()
}
