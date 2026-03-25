struct StatusMessageData: Equatable {
    let text: String
    let isUrgent: Bool
}

enum StatusMessage {
    static func forGame(_ game: Game) -> StatusMessageData {
        switch game.status {
        case .inProgress:
            let player = game.currentPlayer == .attacker ? "Attacker" : "Defender"
            return StatusMessageData(text: "\(player)'s turn (move \(game.moveHistory.count + 1))", isUrgent: false)
        case .attackerWins:
            return StatusMessageData(text: "Attackers win! King captured.", isUrgent: true)
        case .defenderWins:
            return StatusMessageData(text: "Defenders win! King escaped.", isUrgent: true)
        case .draw:
            return StatusMessageData(text: "Game drawn.", isUrgent: true)
        }
    }
}
