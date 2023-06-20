//
//  PopUpDone.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI

struct PopUpDone: View {
    @Binding var screen: Int
    @Binding var timeRemaining: Int
    @Binding var timerMode: TimerMode
    @Binding var timeElapsed: TimeInterval
    @Binding var matrix: [Int]
    @Binding var difficulty: Difficulty
    
    @State var timerCount: Int = 0
    
    @State private var position: CGFloat = 0.001
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        Spacer()
                        Text("You Won!!")
                            .font(.system(size: geometry.size.height * 0.04))
                            .fontWeight(.bold)
                        Spacer()
                        
                        HStack {
                            Text("Duration :")
                            Text("\(timeElapsed.formattedMilliseconds())")
                        }
                        .font(.system(size: geometry.size.width * 0.04))
                        .foregroundColor(.black)
                        
                        switch difficulty {
                        case .medium:
                            Text("You Get 1 Hint")
                                .font(.system(size: geometry.size.height * 0.02))
                        case .hard:
                            Text("You Get 2 Hint")
                                .font(.system(size: geometry.size.height * 0.02))
                        default:
                            Text("")
                        }
                        
                        Spacer()
                        
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
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                    
                    HStack(alignment: .top) {
                        if (Double(timeRemaining) > (Double(timerCount) * 0.66)){
                            Image("Star1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        } else if (Double(timeRemaining) > (Double(timerCount) * 0.33)) {
                            Image("Star2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        } else {
                            Image("Star3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.35)
                                .scaleEffect(position)
                                .animation(Animation.easeIn(duration: 0.4).delay(0.3), value: position)
                        }
                    }
                    .offset(y: -(geometry.size.width * 0.25))
                }
                .onAppear{
                    position = 1
                    stop()
                    var star: Int
                    
                    switch difficulty {
                    case .easy:
                        timerCount = 75
                    case .medium:
                        timerCount = 350
                        DataController().addHint(hintAdd: 1)
                    case .hard:
                        timerCount = 999
                        DataController().addHint(hintAdd: 2)
                    }
                    
                    if (Double(timeRemaining) > (Double(timerCount) * 0.66)) {
                        star = 3
                    } else if (Double(timeRemaining) > (Double(timerCount) * 0.33)) {
                        star = 2
                    } else {
                        star = 1
                    }
                    
                    DataController().addItem(difficulty: difficulty, timeElapsed: timeElapsed, matrix: matrix, star: star)
                }
            }
        }
    }
    
    func stop() {
        timerMode = .stopped
    }
}
