struct TurnIndicatorData: Equatable {
    let currentPlayer: Player
    let moveNumber: Int
    let label: String
}

enum TurnIndicator {
    static func data(for game: Game) -> TurnIndicatorData {
        let moveNum = game.moveHistory.count + 1
        let label = game.currentPlayer == .attacker ? "Attacker's Turn" : "Defender's Turn"
        return TurnIndicatorData(
            currentPlayer: game.currentPlayer,
            moveNumber: moveNum,
            label: label
        )
    }
}
