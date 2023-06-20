//
//  ContentView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var screen: Int
    @Binding var difficulty: Difficulty
    @StateObject var generalData = GeneralDataFunction()
    
    @State private var int: [Int] = [0,0,0,0,0,0,0,0,0]
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
                    if (difficulty != .easy) {
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
                        generalData.restart()
                    } label: {
                        Image("Restart")
                            .resizable()
                            .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                    }
                    Button {
                        generalData.hintFunc(difficulty: difficulty)
                        numberHintClick = DataController().profile[0].hint!.intValue
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
                            if (self.timeRemaining > 0 && !generalData.isDone && !alertPause && !isOpen) {
                                self.timeRemaining -= 1
                            }
                            
                            if (self.timeRemaining == 0 && !generalData.isDone){
                                isLose = true
                            }
                            
                            if (generalData.isDone) {
                                timer.upstream.connect().cancel()
                            }
                        }
                        .frame(width: geometry.size.width * 0.12)
                    Text("seconds")
                }
                .font(.system(size: geometry.size.width * 0.06))
                .foregroundColor(.black)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                
                switch difficulty {
                case .easy:
                    EasyAnswer(generalData: generalData)
                case .medium:
                    MediumAnswer(generalData: generalData)
                case .hard:
                    HardAnswer(generalData: generalData)
                }
                
                Rectangle()
                    .fill(.black)
                    .frame(height: 3, alignment: .bottom)
                
                switch difficulty{
                case .easy:
                    EasyButton(generalData: generalData)
                case .medium:
                    MediumButton(generalData: generalData)
                case .hard:
                    HardButton(generalData: generalData)
                }
                Spacer()
            }
            .onAppear{
                numberHintClick = DataController().profile[0].hint!.intValue
                generalData.answrGenerate(difficulty: difficulty)
                
                switch difficulty {
                case .easy:
                    timeRemaining = 75
                case .medium:
                    timeRemaining = 350
                case .hard:
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
                    PopUpStart(isOpen: $isOpen, timerMode: $timerMode)
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
                                generalData.restart()
                                
                                switch difficulty {
                                case .easy:
                                    timeRemaining = 75
                                case .medium:
                                    timeRemaining = 350
                                case .hard:
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
                            timerMode = .stopped
                        }
                        .scaleEffect(position)
                        .animation(Animation.easeInOut(duration: 0.3), value: position)
                    }
                    
                } else if (generalData.isDone) {
                    PopUpDone(screen: $screen, timeRemaining: $timeRemaining, timerMode: $timerMode, timeElapsed: $timeElapsed, matrix: $generalData.answr, difficulty: $difficulty)
                } else if(alertPause) {
                    PopUpPause(alertPause: $alertPause, timerMode: $timerMode)
                } else if(alertBack) {
                    PopUpBack(alertBack: $alertBack, timerMode: $timerMode, screen: $screen)
                }
            }
        }
    }
    
    func updateTime() {
        if timerMode == .running {
            timeElapsed += 0.01
        }
    }
    
    func pause() {
        timerMode = .paused
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(screen: .constant(3), difficulty: .constant(.easy))
    }
}
