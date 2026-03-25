struct GameStatusBar: Equatable {
    let text: String
    let isUrgent: Bool
    let showTimer: Bool

    static func forState(player: Player, status: GameStatus) -> GameStatusBar {
        switch status {
        case .inProgress:
            let label = player == .attacker ? "Attacker's move" : "Defender's move"
            return GameStatusBar(text: label, isUrgent: false, showTimer: true)
        case .attackerWins:
            return GameStatusBar(text: "Attackers win!", isUrgent: true, showTimer: false)
        case .defenderWins:
            return GameStatusBar(text: "Defenders win!", isUrgent: true, showTimer: false)
        case .draw:
            return GameStatusBar(text: "Game drawn", isUrgent: false, showTimer: false)
        }
    }
}
