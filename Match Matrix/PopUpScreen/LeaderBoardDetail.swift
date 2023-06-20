//
//  PopUpView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 13/04/23.
//

import SwiftUI


struct LeaderBoardDetail: View {
    @Binding var isDetail: Bool
    @Binding var dataId: String
    @State private var position: CGFloat = 1
    
    @State var matrixData: Matrix? = nil
    @State var matrix: [Int] = [0,0,0,0,0,0,0,0,0]
    @State var difficulty: String = ""
    
    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack {
                                if (matrixData?.star == 3){
                                    Image("Star1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                } else if (matrixData?.star == 2) {
                                    Image("Star2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                } else if (matrixData?.star == 1) {
                                    Image("Star3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.35)
                                }
                                
                                switch matrixData?.difficulty {
                                case 1:
                                    VStack{
                                        HStack{
                                            ForEach (0..<2){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (2..<4){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                    }
                                case 2:
                                    VStack{
                                        HStack{
                                            ForEach (0..<3){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (3..<6){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (6..<9){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                    }
                                case 3:
                                    VStack{
                                        HStack{
                                            ForEach (0..<4){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (4..<8){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (8..<12){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                        HStack{
                                            ForEach (12..<16){ index in
                                                RectangleView2{
                                                    Text(String(matrix[index]))
                                                }
                                            }
                                        }
                                    }
                                default:
                                    Text("default view")
                                }
                                                                
                                Text("Difficulty: \(difficulty)")
                                Text("Duration: \(matrixData?.duration ?? "")")
                            }
                            .padding(.top, geometry.size.height * 0.04)
                            .padding(.bottom, geometry.size.height * 0.03)
                            .padding(.horizontal, geometry.size.width * 0.1)
                            .font(.system(size: geometry.size.height * 0.04))
                            .foregroundColor(.white)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isDetail.toggle()
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
                        matrixData = DataController().getObjectByID(stringId: dataId)
                        matrix = matrixData?.matrix as! [Int]
                        
                        if matrixData?.difficulty == 1 {
                            difficulty = "Easy"
                        } else if matrixData?.difficulty == 2 {
                            difficulty = "Medium"
                        } else if matrixData?.difficulty == 3 {
                            difficulty = "Hard"
                        }
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct RectangleView2<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image("Rectangle3")
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


