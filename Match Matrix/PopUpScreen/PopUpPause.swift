//
//  PopUpPause.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI

struct PopUpPause: View {
    @Binding var alertPause: Bool
    @Binding var timerMode: TimerMode
    @State private var position: CGFloat = 0.001
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            HStack {
                                Button {
                                    alertPause = false
                                    start()
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                            
                            Text("Pause")
                                .foregroundColor(.white)
                                .font(.system(size: geometry.size.height * 0.07))
                                .fontWeight(.semibold)
                        }
                    }
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
            }
        }
    }
    
    func start() {
        timerMode = .running
    }
}
