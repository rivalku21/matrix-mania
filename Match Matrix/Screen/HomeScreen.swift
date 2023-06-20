//
//  HomeScreen.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/04/23.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Namespace var namespace
    @State private var position: CGFloat = 0
    @State private var screen: Int = 1
    @State private var difficulty: Difficulty = .easy
    
    var body: some View {
        NavigationStack{
            ZStack{
                if(screen == 1){
                    HomeView(screen: $screen, namespace: namespace)
                } else if (screen == 2){
                    TutorialView(screen: $screen, namespace: namespace)
                } else if (screen == 3) {
                    ContentView(screen: $screen, difficulty: $difficulty)
                } else if (screen == 4) {
                    levelView(screen: $screen, difficulty: $difficulty)
                }
            }
            .background(
                Image("Background")
                    .offset(x: position)
                    .onAppear {
                        self.position = 250
                    }
                    .animation(.easeInOut(duration: 60.0).repeatForever(), value: position)
            )
        }
    }
}

struct HomeView: View {
    @Binding var screen: Int
    let namespace: Namespace.ID
    @State private var position: CGFloat = 0
    @State private var isLeaderBoard: Bool = false
    @State private var isShop: Bool = false
    @State private var isDetail: Bool = false
    @State var objectIDString: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.03){
                HStack {
                    Button {
                        isShop.toggle()
                    } label: {
                        Image("Shop")
                            .resizable()
                            .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                    }
                    
                    Spacer()
                    
                    Button {
                        isLeaderBoard.toggle()
                    } label: {
                        Image("Prize")
                            .resizable()
                            .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                    }
                }
                .frame(maxWidth: geometry.size.width * 0.5)
                
                VStack{
                    Image("Icon")
                        .resizable()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    Text("Matrix Mania")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                }
                
                Button {
                    withAnimation {
                        screen = 4
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack{
                            Text("PLAY")
                            Image(systemName: "play.fill")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                
                Button {
                    withAnimation {
                        screen = 2
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack{
                            Text("TUTORIAL")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                .matchedGeometryEffect(id: "image1", in: namespace)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .overlay {
                if (isLeaderBoard && !isShop && !isDetail) {
                    LeaderBoard(isLeaderBoard: $isLeaderBoard, isDetail: $isDetail, objectIDString: $objectIDString)
                }
                else if (isShop && !isLeaderBoard && !isDetail){
                    Shopping(isShop: $isShop)
                }
                else if (isLeaderBoard && isDetail && !isShop){
                    LeaderBoardDetail(isDetail: $isDetail, dataId: $objectIDString)
                }
            }
        }
    }
}

struct TutorialView: View {
    @Binding var screen: Int
    let namespace: Namespace.ID
    @State private var position: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    Image("Background2")
                        .resizable()
                    VStack(spacing: geometry.size.height * 0.03){
                        Text("TUTORIAL")
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.height * 0.04))
                        VStack(alignment: .leading, spacing: geometry.size.height * 0.03){
                            Text("GOAL:")
                                .fontWeight(.bold)
                                .font(.system(size: geometry.size.height * 0.03))
                            Text("Let's have fun! The goal of this game is to match the numbers in the matrix below with the ones above before time runs out.")
                            Text("RULES:")
                                .fontWeight(.bold)
                                .font(.system(size: geometry.size.height * 0.03))
                            HStack(alignment: .top){
                                Text("1.")
                                Text("Clicking on a number in the box increases its value along with its adjacent boxes (left, right, top, bottom) by 1")
                            }
                            HStack(alignment: .top){
                                Text("2.")
                                Text("Number in the box cannot be reduced")
                            }
                            HStack(alignment: .top){
                                Text("3.")
                                Text("If the number in the box is clicked and its value is 9, then the value of the number will reset to 0.")
                            }
                        }
                        .font(.system(size: geometry.size.height * 0.025))
                    }
                    .padding(geometry.size.width * 0.06)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(.white)
                    
                    HStack {
                        Button {
                            withAnimation {
                                screen = 1
                            }
                        } label: {
                            Image("Close")
                                .resizable()
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(geometry.size.width * 0.03)
                }
                .padding()
                
                Button {
                    withAnimation {
                        screen = 4
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack{
                            Text("CONTINUE")
                            Image(systemName: "play.fill")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                .matchedGeometryEffect(id: "image1", in: namespace)
                
            }
            .padding()
        }
    }
}

struct levelView: View {
    @Binding var screen: Int
    @Binding var difficulty: Difficulty
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.02){
                Button {
                    difficulty = .easy
                    withAnimation {
                        screen = 3
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        Text("EASY")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                
                Button {
                    difficulty = .medium
                    withAnimation {
                        screen = 3
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        Text("MEDIUM")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                
                Button {
                    difficulty = .hard
                    withAnimation {
                        screen = 3
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        Text("HARD")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.width * 0.06))
                    }
                }
                
                Button {
                    withAnimation {
                        screen = 1
                    }
                } label: {
                    ZStack{
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        Text("BACK")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: geometry.size.width * 0.06))
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
