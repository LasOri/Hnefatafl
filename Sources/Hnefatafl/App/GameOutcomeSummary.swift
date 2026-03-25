struct OutcomeSummary: Equatable {
    let winner: Player?
    let moveCount: Int
    let description: String
}

struct GameOutcomeSummary {
    static func summarize(status: GameStatus, moveCount: Int) -> OutcomeSummary? {
        switch status {
        case .inProgress:
            return nil
        case .attackerWins:
            return OutcomeSummary(
                winner: .attacker,
                moveCount: moveCount,
                description: "Attackers win by surrounding the King in \(moveCount) moves!"
            )
        case .defenderWins:
            return OutcomeSummary(
                winner: .defender,
                moveCount: moveCount,
                description: "Defender wins! The King escaped to a corner in \(moveCount) moves."
            )
        case .draw:
            return OutcomeSummary(
                winner: nil,
                moveCount: moveCount,
                description: "The game ends in a draw after \(moveCount) moves."
            )
        }
    }
}
