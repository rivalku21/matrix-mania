//
//  Match_MatrixApp.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/04/23.
//

import SwiftUI

@main
struct MatchMatrixApp: App {
    @StateObject var gameCenterManager = GameCenterManager()
    var body: some Scene {
        WindowGroup {
            BaseScreen()
                .environmentObject(gameCenterManager)
        }
    }
}
