//
//  ContentView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var screen: Int
    @Binding var difficulty: Int
    @State var answr: [Int] = [0,0,0,0,0,0,0,0,0]
    @State private var int: [Int] = [0,0,0,0,0,0,0,0,0]
    @State var isDone: Bool = false
    @State var isLose: Bool = false
    @State var isOpen: Bool = true
    @State var alertPause: Bool = false
    @State var alertBack: Bool = false
    
    @State private var timeRemaining = 0
    @State private var position: CGFloat = 0.001
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var timeElapsed: TimeInterval = 0.0
    @State var timerMode: TimerMode = .stopped
    var stopWatch = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State private var hint: [Int] = []
    @State private var numberHintClick: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.02){
                HStack(spacing: geometry.size.width * 0.02){
                    if (difficulty != 1) {
                        Button {
                            pause()
                            alertBack.toggle()
                        } label: {
                            Image("Close1")
                                .resizable()
                                .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                        }
                    }
                    Button {
                        alertPause = true
                        pause()
                    } label: {
                        Image("Pause")
                            .resizable()
                            .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                    }
                    Button {
                        restart()
                    } label: {
                        Image("Restart")
                            .resizable()
                            .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                    }
                    Button {
                        hintFunc()
                    } label: {
                        ZStack {
                            Image("Hint")
                                .resizable()
                            .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                            
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                
                                Circle()
                                    .stroke(lineWidth: 2.0)
                                    .fill(Color.white)
                                .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                
                                Text("\(numberHintClick)")
                                    .font(.system(size: geometry.size.height * 0.02))
                            }
                            .frame(maxWidth: geometry.size.height * 0.08, maxHeight: geometry.size.height * 0.08, alignment: .bottomTrailing)
                        }
                    }
                    .disabled(numberHintClick <= 0)
                    
                }
                .frame(maxWidth: geometry.size.width * 0.6)
                .onReceive(stopWatch) { _ in
                    updateTime()
                }
                
                HStack(spacing: 10){
                    Text("Time left:")
                    Text("\(timeRemaining)")
                        .onReceive(timer) { _ in
                            if (self.timeRemaining > 0 && !isDone && !alertPause && !isOpen) {
                                self.timeRemaining -= 1
                            }
                            
                            if (self.timeRemaining == 0 && !isDone){
                                isLose = true
                            }
                        }
                        .frame(width: geometry.size.width * 0.12)
                    Text("seconds")
                }
                .font(.system(size: geometry.size.width * 0.06))
                .foregroundColor(.black)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                
                VStack{
                    HStack{
                        ForEach (0..<3){ index in
                            RectangleView{
                                Text(String(answr[index]))
                            }
                        }
                    }
                    HStack{
                        ForEach (3..<6){ index in
                            RectangleView{
                                Text(String(answr[index]))
                            }
                        }
                    }
                    HStack{
                        ForEach (6..<9){ index in
                            RectangleView{
                                Text(String(answr[index]))
                            }
                        }
                    }
                }
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 3, alignment: .bottom)
                
                VStack{
                    HStack{
                        buttonView(num: [0, 1, 3])
                        buttonView(num: [1, 0, 2, 4])
                        buttonView(num: [2, 1, 5])
                    }
                    
                    HStack{
                        buttonView(num: [3, 0, 4, 6])
                        buttonView(num: [4, 1, 3, 5, 7])
                        buttonView(num: [5, 2, 4, 8])
                    }
                    
                    HStack{
                        buttonView(num: [6, 3, 7])
                        buttonView(num: [7, 4, 6, 8])
                        buttonView(num: [8, 5, 7])
                    }
                }
                Spacer()
            }
            .onAppear{
                numberHintClick = DataController().profile[0].hint!.intValue
                
                answr = generator(difficulty: difficulty)
                if difficulty == 1 {
                    timeRemaining = 75
                } else if difficulty == 2 {
                    timeRemaining = 350
                } else if difficulty == 3 {
                    timeRemaining = 999
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .overlay {
                if (isOpen){
                    popUpStart(isOpen: $isOpen, timerMode: $timerMode)
                } else if (isLose){
                    ZStack(alignment: .center) {
                        Color.black.opacity(0.4).ignoresSafeArea()
                        VStack{
                            Spacer()
                            Text("You Lose !!!")
                                .font(.system(size: geometry.size.height * 0.04))
                                .fontWeight(.bold)
                            
                            Spacer()
                            Button {
                                restart()
                                
                                if difficulty == 1 {
                                    timeRemaining = 75
                                } else if difficulty == 2 {
                                    timeRemaining = 350
                                } else if difficulty == 3 {
                                    timeRemaining = 999
                                }
                                
                                isLose = false
                            } label: {
                                ZStack{
                                    Image("Table")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                    Text("Try Again")
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .fontWeight(.bold)
                                }
                            }
                            
                            
                            Button {
                                withAnimation {
                                    screen = 1
                                }
                            } label: {
                                ZStack {
                                    Image("Table")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                    Text("Home")
                                        .font(.system(size: geometry.size.height * 0.025))
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5, alignment: .center)
                        .cornerRadius(20)
                        .background(
                            Image("Background2")
                                .resizable()
                        )
                        .onAppear{
                            position = 1
                            timerMode = .paused
                        }
                        .scaleEffect(position)
                        .animation(Animation.easeInOut(duration: 0.3), value: position)
                    }
                    
                } else if (isDone) {
                    popUpDone(screen: $screen, timeRemaining: $timeRemaining, timerMode: $timerMode, timeElapsed: $timeElapsed, matrix: $answr, difficulty: $difficulty)
                } else if(alertPause) {
                    popUpPause(alertPause: $alertPause, timerMode: $timerMode)
                } else if(alertBack) {
                    popBack(alertBack: $alertBack, timerMode: $timerMode, screen: $screen)
                }
            }
        }
    }
    
    private func buttonView(num: [Int]) -> some View {
        GeometryReader { geometry in
            ZStack{
                if(int[num[0]] == answr[num[0]]){
                    Image("Rectangle3")
                        .resizable()
                        .frame(width: geometry.size.height, height: geometry.size.height)
                } else {
                    Image("Rectangle2")
                        .resizable()
                        .frame(width: geometry.size.height, height: geometry.size.height)
                }
                Button(action: {
                    PlusOne(numbers: num)
                    checking()
                }, label: {
                    Text(String(int[num[0]]))
                        .font(.system(size: geometry.size.height * 0.4))
                })
                .cornerRadius(8)
            }
        }
        .scaledToFit()
    }
    
    func updateTime() {
        if timerMode == .running {
            timeElapsed += 0.01
        }
    }
    
    private func checking() {
        if(int == answr){
            isDone = true
            timer.upstream.connect().cancel()
        }
    }
    
    private func restart() {
        var num: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        
        for i in 0..<hint.count {
            if let index = num.firstIndex(of: hint[i]) {
                num.remove(at: index)
            }
        }
        
        for i in 0..<num.count {
            int[num[i]] = 0
        }
    }
    
    private func PlusOne(numbers: [Int]){
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
    }
    
    func pause() {
        timerMode = .paused
    }
    
    func hintFunc() {
        var randomHint: Int = Int.random(in: 0...8)
        
        while hint.contains(randomHint) || int[randomHint] == answr[randomHint] {
            randomHint = Int.random(in: 0...8)
            continue
        }
        
        hint.append(randomHint)
        int[randomHint] = answr[randomHint]
        
        DataController().addHint(hintAdd: -1)
        numberHintClick = DataController().profile[0].hint!.intValue
        
        checking()
    }
}

struct RectangleView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image("Rectangle1")
                .resizable()
                .frame(width: geometry.size.height, height: geometry.size.height)
                .overlay {
                    self.content
                }
                .font(.system(size: geometry.size.height * 0.4))
        }
        .scaledToFit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(screen: .constant(3), difficulty: .constant(1))
    }
}
