struct GameSummaryResult: Equatable {
    let text: String
    let moveCount: Int
    let status: GameStatus
    let attackerCount: Int
    let defenderCount: Int
}

enum GameSummary {
    static func generate(game: Game) -> GameSummaryResult {
        let pos = game.position
        var attackerCount = 0
        var defenderCount = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch pos.pieceAt(row: row, col: col) {
                case .attacker: attackerCount += 1
                case .defender, .king: defenderCount += 1
                case nil: break
                }
            }
        }

        let statusText: String
        switch game.status {
        case .inProgress: statusText = "Game in progress"
        case .attackerWins: statusText = "Attacker wins"
        case .defenderWins: statusText = "Defender wins"
        case .draw: statusText = "Draw"
        }

        let currentPlayerText = game.currentPlayer == .attacker ? "Attacker" : "Defender"
        let moveCount = game.moveHistory.count

        let text = """
        \(statusText)
        Moves: \(moveCount)
        Current turn: \(currentPlayerText)
        Attacker pieces: \(attackerCount)
        Defender pieces: \(defenderCount)
        """

        return GameSummaryResult(
            text: text,
            moveCount: moveCount,
            status: game.status,
            attackerCount: attackerCount,
            defenderCount: defenderCount
        )
    }
}
