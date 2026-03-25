struct PieceBalanceResult: Equatable {
    let attackers: Int
    let defenders: Int
    let hasKing: Bool

    var ratio: Double {
        guard defenders > 0 else { return attackers > 0 ? Double(attackers) : 0 }
        return Double(attackers) / Double(defenders)
    }

    var advantageLabel: String {
        if attackers > defenders * 2 { return "Attacker advantage" }
        if defenders > attackers { return "Defender advantage" }
        if attackers == defenders { return "Even balance" }
        return "Attacker advantage"
    }

    var attackerPercentage: Int {
        let total = attackers + defenders
        guard total > 0 else { return 0 }
        return (attackers * 100) / total
    }
}

struct PieceBalance {
    static func compute(position: Position) -> PieceBalanceResult {
        var attackers = 0
        var defenders = 0
        var hasKing = false
        for cell in position.cells {
            switch cell {
            case .attacker: attackers += 1
            case .defender: defenders += 1
            case .king: hasKing = true; defenders += 1
            case nil: break
            }
        }
        return PieceBalanceResult(attackers: attackers, defenders: defenders, hasKing: hasKing)
    }
}
