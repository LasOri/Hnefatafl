struct GameRecordEntry: Equatable {
    let moveCount: Int
    let result: GameStatus
    let playerSide: Player
    let date: String

    var isWin: Bool {
        switch result {
        case .attackerWins: return playerSide == .attacker
        case .defenderWins: return playerSide == .defender
        case .inProgress, .draw: return false
        }
    }
}
