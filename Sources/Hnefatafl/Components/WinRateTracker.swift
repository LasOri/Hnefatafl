struct WinRate: Equatable {
    let wins: Int
    let losses: Int
    let draws: Int
    var total: Int { wins + losses + draws }
    var winPercentage: Double {
        guard total > 0 else { return 0 }
        return Double(wins) / Double(total) * 100
    }
}

struct WinRateTracker: Equatable {
    private(set) var attackerRate: WinRate = WinRate(wins: 0, losses: 0, draws: 0)
    private(set) var defenderRate: WinRate = WinRate(wins: 0, losses: 0, draws: 0)

    mutating func recordResult(winner: Player?) {
        switch winner {
        case .attacker:
            attackerRate = WinRate(wins: attackerRate.wins + 1, losses: attackerRate.losses, draws: attackerRate.draws)
            defenderRate = WinRate(wins: defenderRate.wins, losses: defenderRate.losses + 1, draws: defenderRate.draws)
        case .defender:
            attackerRate = WinRate(wins: attackerRate.wins, losses: attackerRate.losses + 1, draws: attackerRate.draws)
            defenderRate = WinRate(wins: defenderRate.wins + 1, losses: defenderRate.losses, draws: defenderRate.draws)
        case .none:
            attackerRate = WinRate(wins: attackerRate.wins, losses: attackerRate.losses, draws: attackerRate.draws + 1)
            defenderRate = WinRate(wins: defenderRate.wins, losses: defenderRate.losses, draws: defenderRate.draws + 1)
        }
    }
}
