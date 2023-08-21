//
//  HomeScreen.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameCenterManager: GameCenterManager
    @Binding var screen: Int
    let namespace: Namespace.ID
    @State private var position: CGFloat = 0
    @State private var isLeaderBoard: Bool = false
    @State private var isShop: Bool = false
    @State private var isDetail: Bool = false
    @State var objectIDString: String = ""

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.03) {
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
//                        isLeaderBoard.toggle()
                        gameCenterManager.showLeaderboard()
                    } label: {
                        Image("Prize")
                            .resizable()
                            .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                    }
                }
                .frame(maxWidth: geometry.size.width * 0.5)
                VStack {
                    Image("Icon")
                        .resizable()
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                        .matchedGeometryEffect(id: "icon", in: namespace)
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
                    ZStack {
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack {
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
                    ZStack {
                        Image("Table")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                        HStack {
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
                if isLeaderBoard && !isShop && !isDetail {
                    LeaderBoard(
                        isLeaderBoard: $isLeaderBoard,
                        isDetail: $isDetail,
                        objectIDString: $objectIDString
                    )
                } else if isShop && !isLeaderBoard && !isDetail {
                    Shopping(
                        isShop: $isShop
                    )
                } else if isLeaderBoard && isDetail && !isShop {
                    LeaderBoardDetail(
                        isDetail: $isDetail,
                        dataId: $objectIDString
                    )
                }
            }
        }
    }
}
