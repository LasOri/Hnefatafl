struct GameClock: Equatable {
    private var attackerRemaining: Int
    private var defenderRemaining: Int
    let incrementSeconds: Int
    private var attackerElapsed: Int = 0
    private var defenderElapsed: Int = 0

    init(initialSeconds: Int, incrementSeconds: Int) {
        self.attackerRemaining = initialSeconds
        self.defenderRemaining = initialSeconds
        self.incrementSeconds = incrementSeconds
    }

    func remainingSeconds(for player: Player) -> Int {
        player == .attacker ? attackerRemaining : defenderRemaining
    }

    mutating func consumeTime(player: Player, seconds: Int) {
        switch player {
        case .attacker:
            attackerElapsed += seconds
            attackerRemaining = max(0, attackerRemaining - seconds)
        case .defender:
            defenderElapsed += seconds
            defenderRemaining = max(0, defenderRemaining - seconds)
        }
    }

    mutating func addIncrement(player: Player) {
        switch player {
        case .attacker: attackerRemaining += incrementSeconds
        case .defender: defenderRemaining += incrementSeconds
        }
    }

    func isFlagged(player: Player) -> Bool {
        remainingSeconds(for: player) == 0
    }

    var totalElapsed: Int {
        attackerElapsed + defenderElapsed
    }
}
