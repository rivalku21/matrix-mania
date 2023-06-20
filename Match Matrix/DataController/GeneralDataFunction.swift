//
//  GeneralDataFunction.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 16/06/23.
//

import Foundation


class GeneralDataFunction: ObservableObject {
    @Published var answr: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @Published var int: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @Published var isDone: Bool = false
    var hint: [Int] = []
    
    
    func answrGenerate(difficulty: Difficulty) {
        let generateValidasi: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        var buttonClick: [Int] = [0,0]
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
        
        for i in 1...randomNum {
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
            
            print("\(i). box \(buttonClick[0] + 1) click \(buttonClick[1]) times")
            
            PlusOne(numbers: buttonClick, difficulty: difficulty)
        }
        
        print("\n\n")
    }
    
    func getClick(number: Int, difficulty: Difficulty) -> [Int] {
        switch difficulty{
        case .easy:
            if number == 0 {
                return [0, 1, 2]
            } else if number == 1 {
                return [1, 0, 3]
            } else if number == 2 {
                return [2, 0, 3]
            } else if number == 3 {
                return [3, 1, 2]
            }
        case .medium:
            if number == 0 {
                return [0, 1, 3]
            } else if number == 1 {
                return [0, 1, 2, 4]
            } else if number == 2 {
                return [1, 2, 5]
            } else if number == 3 {
                return [0, 3, 4, 6]
            } else if number == 4 {
                return [1, 3, 4, 5, 7]
            } else if number == 5 {
                return [2, 4, 5, 8]
            } else if number == 6 {
                return [3, 6, 7]
            } else if number == 7 {
                return [4, 6, 7, 8]
            } else if number == 8 {
                return [5, 7, 8]
            }
        case .hard:
            if number == 0 {
                return [0, 1, 4]
            } else if number == 1 {
                return [0, 1, 2, 5]
            } else if number == 2 {
                return [1, 2, 3, 6]
            } else if number == 3 {
                return [2, 3, 7]
            } else if number == 4 {
                return [0, 4, 5, 8]
            } else if number == 5 {
                return [1, 4, 5, 6, 9]
            } else if number == 6 {
                return [2, 5, 6, 7, 10]
            } else if number == 7 {
                return [3, 6, 7, 11]
            } else if number == 8 {
                return [4, 8, 9, 12]
            } else if number == 9 {
                return [5, 8, 9, 10, 13]
            } else if number == 10 {
                return [6, 9, 10, 11, 14]
            } else if number == 11 {
                return [7, 10, 11, 15]
            } else if number == 12 {
                return [8, 12, 13]
            } else if number == 13 {
                return [9, 12, 13, 14]
            } else if number == 14 {
                return [10, 13, 14, 15]
            } else if number == 15 {
                return [11, 14, 15]
            }
        }
        return []
    }
    
    private func PlusOne(numbers: [Int], difficulty: Difficulty){
        let click = getClick(number: numbers[0], difficulty: difficulty)
        
        for _ in 1...numbers[1] {
            PlusOneSub(numbers: click)
        }
    }

    private func PlusOneSub(numbers: [Int]){
        for j in 0..<numbers.count {
            if (answr[numbers[j]] == 9){
                answr[numbers[j]] = 0
            } else {
                answr[numbers[j]] = answr[numbers[j]] + 1
            }
        }
    }
    
    func ButtonPlusOne(numbers: [Int]) {
        var num: [Int] = numbers
        
        for i in 0..<hint.count {
            if let index = num.firstIndex(of: hint[i]) {
                num.remove(at: index)
            }
        }
        
        for k in 0..<num.count {
            if (int[num[k]] == 9){
                int[num[k]] = 0
            } else {
                int[num[k]] = int[num[k]] + 1
            }
        }
        
        checking()
    }
    
    func restart() {
        var num: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        
        for i in 0..<hint.count {
            if let index = num.firstIndex(of: hint[i]) {
                num.remove(at: index)
            }
        }
        
        for i in 0..<num.count {
            int[num[i]] = 0
        }
    }
    
    func hintFunc(difficulty: Difficulty) {
        var randomHint: Int
        
        switch difficulty{
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
        if(int == answr){
            isDone = true
        }
    }
}


