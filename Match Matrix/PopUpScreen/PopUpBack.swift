//
//  PopUpBack.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI

struct PopUpBack: View {
    @Binding var alertBack: Bool
    @Binding var timerMode: TimerMode
    @Binding var screen: Int
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
                                    alertBack = false
                                    start()
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                            
                            VStack {
                                Spacer()
                                Text("If you go back you lose")
                                    .foregroundColor(.white)
                                    .font(.system(size: geometry.size.height * 0.02))
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
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding()
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
