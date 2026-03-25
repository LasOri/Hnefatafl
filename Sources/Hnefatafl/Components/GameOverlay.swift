enum OverlayType: String, Equatable {
    case pause
    case gameOver
    case help
    case settings
}

struct GameOverlay: Equatable {
    let type: OverlayType
    let isVisible: Bool
    let title: String

    static func pauseOverlay() -> GameOverlay {
        GameOverlay(type: .pause, isVisible: true, title: "Game Paused")
    }

    static func gameOverOverlay(result: GameStatus) -> GameOverlay {
        let title: String
        switch result {
        case .attackerWins:
            title = "Attackers Win!"
        case .defenderWins:
            title = "Defenders Win!"
        case .draw:
            title = "Draw"
        case .inProgress:
            title = "Game Over"
        }
        return GameOverlay(type: .gameOver, isVisible: true, title: title)
    }
}
