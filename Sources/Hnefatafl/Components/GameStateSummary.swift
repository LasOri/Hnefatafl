struct GameStateSummary: Equatable {
    let attackerCount: Int
    let defenderCount: Int
    let currentPlayer: Player
    let moveNumber: Int
    let status: GameStatus

    var isGameActive: Bool {
        status == .inProgress
    }

    var materialAdvantage: String {
        let diff = attackerCount - defenderCount
        if diff > 0 {
            return "Attackers +\(diff)"
        } else if diff < 0 {
            return "Defenders +\(abs(diff))"
        } else {
            return "Even"
        }
    }
}
