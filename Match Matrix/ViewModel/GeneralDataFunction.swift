//
//  GeneralDataFunction.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 16/06/23.
//

import Foundation

class GeneralDataFunction: ObservableObject {
    @Published var answr: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var int: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var isDone: Bool = false
    var hint: [Int] = []

    func answrGenerate(difficulty: Difficulty) {
        let generateValidasi: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var buttonClick: [Int] = [0, 0]
        let randomNum: Int
        if answr != generateValidasi {
            answr = generateValidasi
        }
        // banyaknya button yg diclick
        switch difficulty {
        case .easy:
            randomNum = Int.random(in: 3...4)
        case .medium:
            randomNum = Int.random(in: 5...6)
        case .hard:
            randomNum = Int.random(in: 8...10)
        }
        for integer in 1...randomNum {
            switch difficulty {
            case .easy:
                // button mana yg diclick
                buttonClick[0] = Int.random(in: 0...3)
                // berapa banyak button diclick
                buttonClick[1] = Int.random(in: 1...3)
            case .medium:
                // button mana yg diclick
                buttonClick[0] = Int.random(in: 0...8)
                // berapa banyak button diclick
                buttonClick[1] = Int.random(in: 3...5)
            case .hard:
                // button mana yg diclick
                buttonClick[0] = Int.random(in: 0...15)
                // berapa banyak button diclick
                buttonClick[1] = Int.random(in: 3...6)
            }
            print("\(integer). box \(buttonClick[0] + 1) click \(buttonClick[1]) times")
            plusOne(numbers: buttonClick, difficulty: difficulty)
        }
        print("\n\n")
    }

    func getClick(number: Int, difficulty: Difficulty) -> [Int] {
        switch difficulty {
        case .easy:
            return numberClickPlusOneEasy[number]
        case .medium:
            return numberClickPlusOneMedium[number]
        case .hard:
            return numberClickPlusOneHard[number]
        }
    }

    private func plusOne(numbers: [Int], difficulty: Difficulty) {
        let click = getClick(number: numbers[0], difficulty: difficulty)
        for _ in 1...numbers[1] {
            plusOneSub(numbers: click)
        }
    }

    private func plusOneSub(numbers: [Int]) {
        for index in 0..<numbers.count {
            if answr[numbers[index]] == 9 {
                answr[numbers[index]] = 0
            } else {
                answr[numbers[index]] += 1
            }
        }
    }

    func buttonPlusOne(numbers: [Int]) {
        var num: [Int] = numbers
        for countNum in 0..<hint.count {
            if let index = num.firstIndex(of: hint[countNum]) {
                num.remove(at: index)
            }
        }
        for numCount in 0..<num.count {
            if int[num[numCount]] == 9 {
                int[num[numCount]] = 0
            } else {
                int[num[numCount]] += 1
            }
        }
        checking()
    }

    func restart() {
        var num: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        for numCount in 0..<hint.count {
            if let index = num.firstIndex(of: hint[numCount]) {
                num.remove(at: index)
            }
        }
        for countNum in 0..<num.count {
            int[num[countNum]] = 0
        }
    }

    func hintFunc(difficulty: Difficulty) {
        var randomHint: Int
        switch difficulty {
        case .easy:
            randomHint = Int.random(in: 0...3)
        case .medium:
            randomHint = Int.random(in: 0...8)
        case .hard:
            randomHint = Int.random(in: 0...15)
        }
        while hint.contains(randomHint) || int[randomHint] == answr[randomHint] {
            randomHint = Int.random(in: 0...8)
            continue
        }
        hint.append(randomHint)
        int[randomHint] = answr[randomHint]
        DataController().addHint(hintAdd: -1)
        checking()
    }

    private func checking() {
        if int == answr {
            isDone = true
        }
    }
}
