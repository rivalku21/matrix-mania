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
                    ZStack(alignment: .leading) {
                        ZStack(alignment: .trailing) {
                            Image("Table")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.035)

                            Text("15:31")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                                .padding(.trailing, 6)
                        }
                        .offset(x: 12)

                        ZStack {
                            Image("Love")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.12)

                            Text("5")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.06))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    ZStack(alignment: .leading) {
                        ZStack(alignment: .trailing) {
                            Image("Table")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.035)

                            Text("9999")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                                .padding(.trailing, 6)
                        }
                        .offset(x: 12)

                        Image("SilverCoin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.12)
                    }

                    Spacer()
                    ZStack(alignment: .leading) {
                        ZStack(alignment: .trailing) {
                            Image("Table")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.035)

                            Text("9999")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                                .padding(.trailing, 6)
                        }
                        .offset(x: 12)

                        Image("GoldCoin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.12)
                    }
                }
                
                Spacer()
                // Main View
                VStack {
                    Image("Level")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.3)
                    
                    levelView(level: "123")
                        .frame(height: geometry.size.height * 0.05)
                }
                Image("Icon")
                    .resizable()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    .matchedGeometryEffect(id: "icon", in: namespace)
                
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
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.1))
                            Image(systemName: "play.fill")
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: geometry.size.width * 0.06))
                    }
                }

                Spacer()
                // Bottom bar
                HStack(alignment: .bottom) {
                    Button {
                        
                    } label: {
                        VStack {
                            Image("Settings")
                                .resizable()
                                .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                            Text("Perubahan")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            screen = 2
                        }
                    } label: {
                        VStack {
                            Image("Faq")
                                .resizable()
                                .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                            Text("Tutorial")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    Button {
                        gameCenterManager.showLeaderboard()
                    } label: {
                        VStack {
                            Image("Prize")
                                .resizable()
                                .frame(width: geometry.size.width * 0.13, height: geometry.size.width * 0.13)
                            Text("Rank")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    Button {
//                        isShop.toggle()
                        screen = 5
                    } label: {
                        VStack {
                            Image("Shop")
                                .resizable()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                            Text("Shop")
                                .font(.custom("SoupofJustice", size: geometry.size.width * 0.04))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .padding(.horizontal, geometry.size.width * 0.1)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .overlay {
                if isLeaderBoard && !isShop && !isDetail {
                    LeaderBoard(
                        isLeaderBoard: $isLeaderBoard,
                        isDetail: $isDetail,
                        objectIDString: $objectIDString
                    )
                } else if isShop && !isLeaderBoard && !isDetail {
//                    Shopping(
//                        isShop: $isShop
//                    )
                } else if isLeaderBoard && isDetail && !isShop {
                    LeaderBoardDetail(
                        isDetail: $isDetail,
                        dataId: $objectIDString
                    )
                }
            }
        }
    }
    
    func levelView(level: String) -> some View {
        return HStack {
            ForEach(Array(level), id: \.self) { character in
                Image(String(character))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
