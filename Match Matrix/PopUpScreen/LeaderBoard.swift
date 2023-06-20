//
//  LeaderBoard.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI

struct LeaderBoard: View {
    @Binding var isLeaderBoard: Bool
    @Binding var isDetail: Bool
    @Binding var objectIDString: String
    
    @State private var position: CGFloat = 0.001
    @State var alertReset: Bool = false
    
    @State var matrixData: [Matrix] = DataController().items
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack {
                                ScrollView {
                                    VStack(spacing: geometry.size.height * 0.01){
                                        ForEach(Array(matrixData.enumerated()), id: \.1) { index, data in
                                            let delay = Double(index) * 0.1
                                            
                                            ExtractedView(isDetail: $isDetail, objectIDString: $objectIDString, data: data, delay: delay)
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(geometry.size.width * 0.01)
                                }
                                .padding(.top, geometry.size.height * 0.08)
                                .padding(.bottom, geometry.size.height * 0.01)
                                .padding(.horizontal, geometry.size.width * 0.02)
                                
                                Button {
                                    DataController().deleteAllData()
                                    matrixData = DataController().items
                                } label: {
                                    ZStack {
                                        Image("Table")
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                        Text("DELETE ALL")
                                            .font(.system(size: geometry.size.height * 0.02))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                
                            }
                            .padding(.bottom, geometry.size.height * 0.03)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isLeaderBoard.toggle()
                                    }
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .background {
                        Image("Background2")
                            .resizable()
                    }
                    .cornerRadius(20)
                    .onAppear{
                        position = 1
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct ExtractedView: View {
    @Binding var isDetail: Bool
    @Binding var objectIDString: String
    var data: Matrix
    
    var delay: Double
    
    @State private var shouldAnimate = false
    
    var body: some View {
        //        GeometryReader { geometry in
        Button(action: {
            isDetail.toggle()
            objectIDString = DataController().stringFromObjectID(data.objectID) ?? ""
        }, label: {
            ZStack {
                Image("TableLong")
                    .resizable()
                    .scaledToFit()
                
                HStack{
                    if data.difficulty == 1 {
                        Text("Easy")
                    } else if data.difficulty == 2 {
                        Text("Medium")
                    } else if data.difficulty == 3 {
                        Text("Hard")
                    }
                    Spacer()
                    Text(data.duration ?? "")
                }
                //                    .font(.system(size: geometry.size.width * 0.04))
                .foregroundColor(.white)
                .padding(.horizontal)
            }
        })
        .offset(x: shouldAnimate ? 0 : -100)
        .animation(
            Animation.interpolatingSpring(mass: 1, stiffness: 50, damping: 10, initialVelocity: 0)
                .delay(delay)
        )
        .onAppear{
            withAnimation {
                shouldAnimate = true
            }
        }
        //        }
    }
}
