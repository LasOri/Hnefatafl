struct GameOverData: Equatable {
    let status: GameStatus
    let message: String
    let moveCount: Int
}

enum GameOverDisplay {
    static func data(for game: Game) -> GameOverData? {
        switch game.status {
        case .inProgress: return nil
        case .attackerWins:
            return GameOverData(status: .attackerWins, message: "Attackers Win!", moveCount: game.moveHistory.count)
        case .defenderWins:
            return GameOverData(status: .defenderWins, message: "Defenders Win!", moveCount: game.moveHistory.count)
        case .draw:
            return GameOverData(status: .draw, message: "Draw!", moveCount: game.moveHistory.count)
        }
    }
}
