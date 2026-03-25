struct GameHistoryEntry: Equatable {
    let id: Int
    let date: String
    let moveCount: Int
    let result: GameStatus
    let playerSide: Player

    var resultText: String {
        switch result {
        case .attackerWins: return "Attacker Wins"
        case .defenderWins: return "Defender Wins"
        case .draw: return "Draw"
        case .inProgress: return "In Progress"
        }
    }
}
