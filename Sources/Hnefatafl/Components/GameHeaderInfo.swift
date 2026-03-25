struct GameHeaderInfo: Equatable {
    let currentPlayer: Player
    let moveNumber: Int
    let gameStatus: GameStatus

    var statusText: String {
        switch gameStatus {
        case .inProgress:
            let playerName = currentPlayer == .attacker ? "Attacker" : "Defender"
            return "\(playerName)'s Turn - Move \(moveNumber)"
        case .attackerWins:
            return "Attackers Win!"
        case .defenderWins:
            return "Defenders Win!"
        case .draw:
            return "Game Drawn"
        }
    }

    var isGameOver: Bool {
        gameStatus != .inProgress
    }
}
