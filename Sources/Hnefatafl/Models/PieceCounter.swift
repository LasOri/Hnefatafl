struct PieceCount: Equatable {
    let attackers: Int
    let defenders: Int
    let hasKing: Bool

    var totalDefenderSide: Int {
        defenders + (hasKing ? 1 : 0)
    }
}

struct PieceCounter {
    static func count(position: Position) -> PieceCount {
        var attackers = 0
        var defenders = 0
        var hasKing = false

        for cell in position.cells {
            switch cell {
            case .attacker: attackers += 1
            case .defender: defenders += 1
            case .king: hasKing = true
            case nil: break
            }
        }

        return PieceCount(attackers: attackers, defenders: defenders, hasKing: hasKing)
    }
}
