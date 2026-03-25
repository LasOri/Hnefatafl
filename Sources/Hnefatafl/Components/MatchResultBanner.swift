struct MatchResultBanner: Equatable {
    let result: GameStatus
    let moveCount: Int

    var title: String {
        switch result {
        case .attackerWins: return "Attackers Win!"
        case .defenderWins: return "Defenders Win!"
        case .draw: return "Draw"
        case .inProgress: return "Game In Progress"
        }
    }

    var subtitle: String {
        "Game ended in \(moveCount) moves"
    }
}
