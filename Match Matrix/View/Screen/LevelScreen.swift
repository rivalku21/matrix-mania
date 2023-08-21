//
//  LevelScreen.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/08/23.
//

import SwiftUI

struct LevelView: View {
    @Binding var screen: Int
    @Binding var difficulty: Difficulty
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.02) {
                Button {
                    difficulty = .easy
                    withAnimation {
                        screen = 3
                    }
                } label: {
                    ZStack {
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
                    ZStack {
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
                    ZStack {
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
                    ZStack {
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
