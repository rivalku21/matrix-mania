//
//  HomeScreen.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/04/23.
//

import SwiftUI
import CoreData

struct BaseScreen: View {
    @Namespace var namespace
    @State private var position: CGFloat = 0
    @State private var screen: Int = 1
    @State private var difficulty: Difficulty = .easy
    @State private var isSplashScreenVisible = true

    var body: some View {
        NavigationStack {
            ZStack {
                if isSplashScreenVisible {
                    SplashScreen(namespace: namespace)
                } else {
                    switch screen {
                    case 1:
                        HomeView(screen: $screen, namespace: namespace)
                    case 2:
                        TutorialView(screen: $screen, namespace: namespace)
                    case 3:
                        ContentView(screen: $screen, difficulty: $difficulty)
                    case 4:
                        LevelView(screen: $screen, difficulty: $difficulty)
                    default:
                        HomeView(screen: $screen, namespace: namespace)
                    }
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
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0).delay(1.0)) {
                    isSplashScreenVisible = false
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        BaseScreen()
    }
}
