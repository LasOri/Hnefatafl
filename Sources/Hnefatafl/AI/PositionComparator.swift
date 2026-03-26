struct PositionComparisonResult: Equatable {
    let changedSquares: Int
    let attackerDiff: Int
    let defenderDiff: Int
    let isIdentical: Bool
    let summary: String
}

enum PositionComparator {
    static func compare(posA: Position, posB: Position) -> PositionComparisonResult {
        var changed = 0
        var attackersA = 0, attackersB = 0
        var defendersA = 0, defendersB = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let pieceA = posA.pieceAt(row: row, col: col)
                let pieceB = posB.pieceAt(row: row, col: col)
                if pieceA != pieceB { changed += 1 }
                switch pieceA {
                case .attacker: attackersA += 1
                case .defender, .king: defendersA += 1
                case nil: break
                }
                switch pieceB {
                case .attacker: attackersB += 1
                case .defender, .king: defendersB += 1
                case nil: break
                }
            }
        }

        let identical = changed == 0
        let attackerDiff = attackersB - attackersA
        let defenderDiff = defendersB - defendersA

        let summary: String
        if identical {
            summary = "Positions are identical"
        } else {
            summary = "\(changed) squares changed, attacker diff: \(attackerDiff), defender diff: \(defenderDiff)"
        }

        return PositionComparisonResult(
            changedSquares: changed,
            attackerDiff: attackerDiff,
            defenderDiff: defenderDiff,
            isIdentical: identical,
            summary: summary
        )
    }
}
