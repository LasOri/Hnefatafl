struct ChessClockState: Equatable {
    var attackerTime: Int
    var defenderTime: Int
    var activePlayer: Player
    var isRunning: Bool

    mutating func tick() {
        guard isRunning else { return }
        switch activePlayer {
        case .attacker:
            attackerTime = max(0, attackerTime - 1)
        case .defender:
            defenderTime = max(0, defenderTime - 1)
        }
    }

    mutating func switchPlayer() {
        activePlayer = activePlayer == .attacker ? .defender : .attacker
    }

    var isExpired: Bool {
        attackerTime == 0 || defenderTime == 0
    }
}
