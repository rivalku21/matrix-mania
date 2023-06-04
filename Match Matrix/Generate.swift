//
//  Generate.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 12/04/23.
//

import Foundation
import AVFoundation

public var generate: [Int] = [0,0,0,0,0,0,0,0,0]

var player: AVAudioPlayer?

public func generator(difficulty: Int) -> [Int] {
    let generateValidasi: [Int] = [0,0,0,0,0,0,0,0,0]
    var buttonClick: [Int] = [0,0]
    let randomNum: Int
    
    // banyaknya button yg diclick
    if difficulty == 1 {
        randomNum = Int.random(in: 3...4)
    } else if difficulty == 2 {
        randomNum = Int.random(in: 5...6)
    } else {
        randomNum = Int.random(in: 7...8)
    }
    
    if generate != generateValidasi {
        generate = generateValidasi
    }
    
    for i in 1...randomNum {
        // button mana yg diclick
        buttonClick[0] = Int.random(in: 0...8)
        
        // berapa banyak button diclick
        if difficulty == 1 {
            buttonClick[1] = Int.random(in: 1...3)
        } else if difficulty == 2 {
            buttonClick[1] = Int.random(in: 1...6)
        } else {
            buttonClick[1] = Int.random(in: 1...9)
        }
         
        print("\(i). box \(buttonClick[0] + 1) click \(buttonClick[1]) times")
        
        PlusOne(numbers: buttonClick)
    }
    
    print("\n\n")
    
    return generate
}

private func PlusOne(numbers: [Int]){
    if(numbers[0] == 0){
        let click = [0, 1, 3]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 1){
        let click = [0, 1, 2, 4]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 2){
        let click = [1, 2, 5]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 3){
        let click = [0, 3, 4, 6]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 4){
        let click = [1, 3, 4, 5, 7]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 5){
        let click = [2, 4, 5, 8]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 6){
        let click = [3, 6, 7]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 7){
        let click = [4, 6, 7, 8]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    } else if(numbers[0] == 8){
        let click = [5, 7, 8]
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    }
}

private func PlusOneSub(numbers: [Int]){
    for j in 0..<numbers.count {
        if (generate[numbers[j]] == 9){
            generate[numbers[j]] = 0
        } else {
            generate[numbers[j]] = generate[numbers[j]] + 1
        }
    }
}

func playSound(name: String){
    let url = Bundle.main.url(forResource: name, withExtension: "mp3")
    
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        
        player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
        
        player!.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

enum TimerMode {
    case running, paused, stopped
}
