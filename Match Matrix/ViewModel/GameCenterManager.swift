//
//  GameCenterManager.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 04/08/23.
//

import GameKit

class GameCenterManager: NSObject, ObservableObject, GKGameCenterControllerDelegate {
    @Published var playerName: String = "Unknown Player"

    override init() {
        super.init()
        authenticatePlayer()
    }

    func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewCon = viewController {
                UIApplication.shared.windows.first?.rootViewController?.present(
                    viewCon, animated: true, completion: nil
                )
            } else if GKLocalPlayer.local.isAuthenticated {
                self.getPlayerName()
            } else {
                print("Game Center authentication failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func getPlayerName() {
        if GKLocalPlayer.local.isAuthenticated {
            playerName = GKLocalPlayer.local.displayName
        }
    }

    func submitScoreToLeaderboard(score: Int) {
        let leaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
        leaderboard.identifier = "m4tr1xMan1a"

        // Load the scores for the authenticated player
        leaderboard.loadScores { scores, error in
            if let error = error {
                print("Failed to load leaderboard data. Error: \(error.localizedDescription)")
            } else if let scores = leaderboard.scores, let currentPlayerScore = scores.first?.value {
                // Calculate the new score by adding the increment amount
                let newScore = currentPlayerScore + Int64(score)

                // Create a GKScore instance and set the new score
                let scoreObj = GKScore(leaderboardIdentifier: leaderboard.identifier!)
                scoreObj.value = Int64(newScore)

                // Submit the updated score
                GKScore.report([scoreObj]) { error in
                    if let error = error {
                        print("Failed to submit score to leaderboard. Error: \(error.localizedDescription)")
                    } else {
                        print("Score submitted to leaderboard successfully.")
                    }
                }
            } else {
                print("No scores found for the current player.")
            }
        }
    }

    func showLeaderboard() {
        // Create a GKGameCenterViewController instance
        let gameCenterViewController = GKGameCenterViewController()

        // Set the view controller as the delegate to dismiss it after use
        gameCenterViewController.gameCenterDelegate = self

        // Specify the leaderboard you want to show (use the same leaderboard ID)
        gameCenterViewController.leaderboardIdentifier = "m4tr1xMan1a"

        // Present the leaderboard view controller modally
        do {
            try UIApplication.shared.windows.first?.rootViewController?.present(
                gameCenterViewController, animated: true, completion: nil
            )
        } catch {
            print("Failed to present Game Center Leaderboard. Error: \(error.localizedDescription)")
        }
    }

}

extension GameCenterManager {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
