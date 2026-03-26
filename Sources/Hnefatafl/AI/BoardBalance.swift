struct BalanceResult: Equatable {
    let attackerCount: Int
    let defenderCount: Int
    let materialAdvantage: Int
    let score: Int
}

enum BoardBalance {
    static func evaluate(position: Position) -> BalanceResult {
        var attackers = 0
        var defenders = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch position.pieceAt(row: row, col: col) {
                case .attacker: attackers += 1
                case .defender, .king: defenders += 1
                case nil: break
                }
            }
        }

        let materialAdvantage = attackers - defenders
        let score = attackers * 10 - defenders * 15

        return BalanceResult(
            attackerCount: attackers,
            defenderCount: defenders,
            materialAdvantage: materialAdvantage,
            score: score
        )
    }
}
