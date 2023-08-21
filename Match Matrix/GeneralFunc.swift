//
//  Generate.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 12/04/23.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?

func playSound(name: String) {
    let url = Bundle.main.url(forResource: name, withExtension: "mp3")
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
        player!.play()
    } catch let error {
        print(error.localizedDescription)
    }
}

extension TimeInterval {
    func formattedMilliseconds() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        let milliseconds = Int(self * 100) % 100
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}

enum TimerMode {
    case running, paused, stopped
}

enum Difficulty {
    case easy
    case medium
    case hard
}

enum HomePopUp {
    case leaderboard
    case shopping
    case leaderboardDetail
    case home
}

enum ScreenView {
    case homeview
    case tutorial
    case content
    case level
}
