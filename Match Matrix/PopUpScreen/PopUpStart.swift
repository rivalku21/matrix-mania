//
//  PopUpStart.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI

struct PopUpStart: View {
    @Binding var isOpen: Bool
    @Binding var timerMode: TimerMode
    @State private var position: CGFloat = 0.001
    @State private var timeToStart = 3
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    ZStack{
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.5)
                        
                        Circle()
                            .stroke(
                                Color.white.opacity(0.8),
                                lineWidth: geometry.size.width * 0.05)
                            .frame(width: geometry.size.width * 0.5)
                        
                        Circle()
                            .trim(from: 0, to: degreeFunc())
                            .stroke(
                                .yellow, style: StrokeStyle(lineWidth: geometry.size.width * 0.05, lineCap: .round))
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: geometry.size.width * 0.5)
                            .rotationEffect(.degrees(degreeFunc()))
                            .animation(Animation.easeInOut(duration: 0.5), value: degreeFunc())
                        
                        Text("\(timeToStart)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.height * 0.09))
                            .onReceive(timer) { _ in
                                if (self.timeToStart > 0) {
                                    self.timeToStart -= 1
                                } else {
                                    timer.upstream.connect().cancel()
                                    start()
                                    isOpen.toggle()
                                }
                            }
                    }
                    .onAppear{
                        position = 1
                        playSound(name: "countdown")
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.5), value: position)
                }
            }
        }
    }
    
    func start() {
        timerMode = .running
    }
    
    private func degreeFunc() -> Double {
        let degree = Double(timeToStart)/3
        return degree
    }
}
